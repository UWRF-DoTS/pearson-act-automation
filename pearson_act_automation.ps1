<#
.SYNOPSIS
    Fetches the encrypted, fixed-width ACT text file from the Pearson website,
    with input from the user for authentication, decrypts (PGP) the file using
    Gpg4win and the private key installed by the user, then converts the 
    fixed-width file to a CSV file. The PGP file and CSV are kept, the TXT 
    file is removed.
.NOTES
    Full Name: pearson_act_automation.ps1
    Author: Shane O'Malley-Potting - shane.omalley-potting@uwrf.edu
    Requires: Gpg4win, private key installed for ran user
    The whatif flag only is not fully implemented. Currently just prevents
    the running of the normal process
#>

. "C:\PATH\pearson_act_field_map.ps1"
. "C:\PATH\pearson_act_release_schedule.ps1"
param([switch]$whatif = $false,[switch]$debug= $false);


$ENCFILE_PATH = ""; #Directory to place the encrypted Pearson ACT File
$ENC_PASSPHRASE = ""; #Private key passphrase
$DECFILE_PATH = ""; #Directory to place the decrypted Pearson ACT File
$PEARSON_UID = "";
$PEARSON_PWD_SS = ""; # Use this variable when using a SecureString file for the password. Preferred
$PEARSON_PWD = ""; # Use when using a hard coded password. Changes will need to be made to make this work

$EventLog = New-Object System.Diagnostics.EventLog('','.', $MyInvocation.MyCommand.Name) # Setting up Windows event log

# All dates and numbers based on https://www.act.org/content/dam/act/unsecured/documents/AIROReportingSchedule.pdf
$holidays = $schedule.holidays;
# Special, additional runs have historically occured; Planning ahead
$specials = $schedule.special_runs;
# Choosing a date (and DSN number) to begin for caluclating current number
$start_date = [DateTime]$start_date = $schedule.start_date;
$startNumber = $schedule.start_code;

$repDate = ""; #Reporting variable
$repNumber = ""; #Reporting variable

# Takes in the DSN number provided by Pearson for the batch ($url), and the Basic Auth credentials
# Returns the file location of the output of the request, or -1 if the request failed
function getPearsonFile($url, $user, $password){
    $basic_auth = "{0}:{1}" -f $user, [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password));
	$basic_auth64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.getBytes($basic_auth));
    $out = "${ENCFILE_PATH}\${url}-" +  (Get-Date -f yyyyMMdd) + ".txt.gpg";
    $headers = @{ Authorization = "Basic " + $basic_auth64};
    $pearson_submit = "https://airo.pearson.com/neon/aftairo.htm?DSN=${url}&SUBMIT=Submit+Request";
    
    try {
        Invoke-WebRequest -uri $pearson_submit -headers $headers -outfile $out;
        return $out;
    }
    catch {
		$EventLog.WriteEntry($_.Exception.Message, "Error");
		$EventLog.WriteEntry("Line Number: $($_.InvocationInfo.ScriptLineNumber)", "Error");
        return "-1";
    }
}

# Determines if the date is one when the file would be created
# Used to do incrementing of the base file name
function run_scheduled($date){
    $scheduled = $false;
    if($date -NotIn $holidays){ # Not processed on observed holidays
        if($date.DayOfWeek -IN @(1,3,5)){ # Processed on M-W-F
            $scheduled = $true;
        } 
        elseif ($date.DayOfWeek -EQ 6 -AND $date.Month % 2 -EQ 0 -AND $date.Day -GT 14 -AND $date.Day -LT 21){ # Processed every other month on the 3rd Saturday
            $scheduled = $true;
        }
        elseif($date -IN $specials){ # Sometimes it is ran specially
            $scheduled = $true;
        }
    }
    return $scheduled;
}

# Increments the dates since our listed start date, and determines what DSN number we should be up to
# The previous day is passed as $d so we can be sure the file exists
function getPearsonFileName($previous){
    $end_date = $start_date; # Changing variable
    $now = $previous; # The date to check
    $inc = 0;
    while($start_date -LE $now){ # Iterate days since the first pair until now
        if(run_scheduled($start_date)){ # If it is applicable, increment, and set the temporary date variable
            $end_date = $start_date;
            $inc++;
        }
        $start_date = $start_date.addDays(1); # Check the next day
    }
	$script:repNumber = ("C" + ($startNumber + (10 * ($inc -1)))); # The variable used for reporting the number
	$script:repDate = $end_date;
	
    return ("C" + ($startNumber + (10 * ($inc -1)))); # Do the math, and it adds one extra by accident. 
}

# Takes in the file location and the desired output file location
# Returns the output file location
function createCSV($in, $out){
    #Add the headers to the CSV file
    $cols = "";
    foreach ($i in $fixed_space_values){
        $cols += $i.column;
        if($i -NE $fixed_space_values[-1]){
            $cols += ",";
        }
    }
    $cols > $out;
    
	try{
		foreach ($line in [System.IO.File]::ReadLines($in)){
			$l = "";
			foreach ($i in $fixed_space_values){
				#Special logic for individual column formatting. 
				#Generally trims and trims 0s from the start and adds a , to the end
				if($i.column -EQ "Telephone 1" -AND $line.substring($i.start,$i.length) -NE "          "){
					$phone = $line.substring($i.start,$i.length);
					$l += "{0}-{1}-{2}," -f $phone.substring(0,3), $phone.substring(3,3), $phone.substring(6,4);
				}
				elseif($i.column -EQ "Norm Types" -OR $i.column -EQ "Blank20" -OR $i.column -EQ  "Understanding Complex Test Score" -OR $i.column -EQ "Zip4"){
					$l += $line.substring($i.start,$i.length).trim() + ",";
				}
				elseif($i.column -EQ "ACT Id"){
					$l += ($line.substring($i.start,$i.length).trim().TrimStart("0") -replace "^-0+", "-") + ",";
				}
				elseif($i.column -EQ "Progress Toward Career Readiness Indicator"){
					$l += $line.substring($i.start,$i.length).trim().TrimStart("0");
				}
				else {
					$l += $line.substring($i.start,$i.length).trim().TrimStart("0") + ",";
				}
			}
			$l >> $out;
		}
	}
	catch {
		$EventLog.WriteEntry($_.Exception.Message, "Error");
		$EventLog.WriteEntry("Line Number: $($_.InvocationInfo.ScriptLineNumber)", "Error");
		$out = "-1"
	}
    return $out;
}



# Takes in the file location of the encrypted file
# Depends on Gpg4win to be installed and the private key to be loaded in the user profile
# Returns the file location of the decrypted file, or -1 if decryption failed
# gpg really didn't like the network paths. Copied files locally processed, moved and deleted
function decrypt($in){
	Copy-Item $in .;
	$file = ([System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileNameWithoutExtension($in)) + ".txt");
    $outfile = $DECFILE_PATH + "\" + [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileNameWithoutExtension($in)) + ".txt" ;    
    try{
        gpg --output $file --keyring $env:APPDATA\gnupg\pubring.gpg --batch --yes  --passphrase ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((ConvertTo-SecureString (Get-Content AdmissionsGPG.ss))))) --decrypt ([System.IO.Path]::GetFileName($in));
		Move-Item $file $outfile;
		Remove-Item ([System.IO.Path]::GetFileName($in)) -Force;
        return $outfile;
    }
    catch {
		$EventLog.WriteEntry($_.Exception.Message, "Error");
		$EventLog.WriteEntry("Line Number: $($_.InvocationInfo.ScriptLineNumber)", "Error");
        return "-1";
    }
}

function main(){
    $pearsonFile = "-1";
    $pre = ""; # We use pearsonFile for the file location; pre is the previous value
    $dsn = getPearsonFileName (Get-Date ((Get-Date).addDays(-1).ToShortDateString())); #Check for yesterday's file
    $pearsonFile = getPearsonFile $dsn $PEARSON_UID (ConvertTo-SecureString (Get-Content $PEARSON_PWD_SS));
	if($pearsonFile -NE "-1"){
		$EventLog.WriteEntry("File from Pearson saved as ${pearsonFile}");
		if($debug) { echo "$(Get-Date): File saved as ${pearsonFile}" >> debug.txt; }
		$pre = $pearsonFile;
		$pearsonFile = decrypt "${pearsonFile}";

		if($pearsonFile -NE "-1"){
			$EventLog.WriteEntry("Decrypted file saved as ${pearsonFile}");
			if($debug) { echo "$(Get-Date): File saved as ${pearsonFile}" >> debug.txt; }
			$pre = $pearsonFile;
			$pearsonFile = createCSV $pearsonFile ($CSVFILE_PATH +"\" + [System.IO.Path]::GetFileNameWithoutExtension($pearsonFile) + ".csv");
			if($pearsonFile -NE "-1"){
				$EventLog.WriteEntry("CSV file saved as ${pearsonFile}");
				if($debug) { echo "$(Get-Date): CSV file saved as ${pearsonFile}" >> debug.txt; }
				$EventLog.WriteEntry("Deleting ${pre}");
				Remove-Item $pre -Force;
				$EventLog.WriteEntry("Process completed successfully");
			}
		}
	}
	return $pearsonFile
}


# Default process
if(!$whatif) {
	$success = $false;
    if(Get-Command Invoke-WebRequest -errorAction SilentlyContinue){
        if(Get-Command gpg -errorAction SilentlyContinue){
            if((gpg --list-keys) -NE $null){
				$temp = main;
                if ($temp -NE "-1" ){
					$suc = $true;
				}
            }
            else {
				$EventLog.WriteEntry("No private key installed to decrypt file", "Error");
            }
        }
        else{
			$EventLog.WriteEntry("Gpg4win is not properly installed.", "Error");
        }
    }
    else {
		$EventLog.WriteEntry("Invoke-WebRequest is not recognized as the name of a cmdlet. Your Powershell version may be out of date. Powershell 3.0 or greater required.", "Error");
    }
	
	if($success){
        <#
            Do success things
        #> 
	}
	else {
        <#
            Do failure things
        #>
	}
}
