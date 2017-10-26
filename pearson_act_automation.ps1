<#
.SYNOPSIS
    Fetches the encrypted, fixed-width ACT text file from the Pearson website,
    with input from the user for authentication, decrypts (PGP) the file using
    Gpg4win and the private key installed by the user, then converts the 
    fixed-width file to a CSV file. The PGP file and CSV are kept, the TXT 
    file is removed.
.NOTES
    Full Name: ACT.ps1
    Author: Shane O'Malley-Potting - shane.omalley-potting@uwrf.edu
    Requires: Gpg4win, private key installed for ran user
#>

. "ACTFields.ps1";

$ENCFILE_PATH = "C:\"; #Directory to place the encrypted Pearson ACT File
$ENC_PASSPHRASE = "PASSPHRASE"; #Private key passphrase
$DECFILE_PATH = "C:\"; #Directory to place the decrypted Pearson ACT File
$CSVFILE_PATH = "C:\";
$PEARSON_UID = "USERID";
$PEARSON_PWD = "PASSWORD";


#All dates and numbers based on https://www.act.org/content/dam/act/unsecured/documents/AIROReportingSchedule.pdf
$holidays = @((Get-Date "09-04-2017"), (Get-Date "11-24-2017"), (Get-Date "12-25-2017"), (Get-Date "09-01-2018"), (Get-Date "05-28-2018"), (Get-Date "07-04-2018"));
# Special, additional runs have historically occured
$specials_runs = @((Get-Date "09-16-2017"), (Get-Date "07-21-2018"));
# Choosing a date (and DSN number) to begin for caluclating current number
$start_date = [DateTime]$start_date = "09/06/2017";
$startNumber = 71110;

# Takes in the DSN number provided by Pearson for the batch and the Basic Auth credentials
# Returns the file location of the output of the request, or -1 if the request failed
function getPearsonFile($dsn, $user, $password){
    $basic_auth = "{0}:{1}" -f $user, [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password));
	$basic_auth_64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.getBytes($basic_auth));
    $out_file = "${ENCFILE_PATH}\${dsn}-" +  (Get-Date -f yyyyMMdd) + ".txt.gpg";
    $headers = @{ Authorization = "Basic " + $basic_auth_64};
    $url = "https://airo.pearson.com/neon/aftairo.htm?DSN=${dsn}&SUBMIT=Submit+Request";
    
    try {
        $resp = Invoke-WebRequest -uri $url -headers $headers -outfile $out_file;
        return $out_file;
    }
    catch {
        return "-1";
    }
}


# Determines if the date is one when the file would be created
# Used to do incrementing of the base file name
function dateMatters($d){
    $matters = $false;
    if($d -NotIn $holidays){ # Not processed on observed holidays
        if($d.DayOfWeek -IN @(1,3,5)){ # Processed on M-W-F
            $matters = $true;
        } 
        elseif ($d.DayOfWeek -EQ 6 -AND $d.Month % 2 -EQ 0 -AND $d.Day -GT 14 -AND $d.Day -LT 21){ # Processed every other month on the 3rd Saturday
            $matters = $true;
        }
        elseif($d -IN $specials_runs){ # Sometimes it is ran specially
            $matters = $true;
        }
    }
    return $matters;
}


# Increments the dates since our listed start date, and determines what DSN number we should be up to
# The previous day is passed as $d so we can be sure the file exists
function getPearsonFileName($d){    
    $temp_date = $start_date; # Changing variable
    $now = $d; # The date to check
    $inc = 0;
    while($start_date -LE $now){ # Iterate days since the first pair until now
        if(dateMatters($start_date)){ # If it is applicable, increment, and set the temporary date variable
            $temp_date = $start_date;
            $inc++;
        }
        $start_date = $start_date.addDays(1); # Check the next day
    }
    return ("C" + ($startNumber + (10 * ($inc -1)))); # Do the math, and it adds one extra by accident. 
}

# Takes in the file location and the desired output file location
# Returns the output file location
function createCSV($in, $out){
    #Add the headers to the CSV file
    $cols = "";
    foreach ($i in $fixed_space_values){
        $cols += $i.column;
        if($i -NE $sdv[-1]){
            $cols += ",";
        }
    }
    $cols > $out; #Outputs the columns as the first row
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
			$l >> $out; #Append new lines
		}
	}
	catch {
		$out = "-1"
	}
    return $out;
}


# Takes in the file location of the encrypted file
# Depends on Gpg4win to be installed and the Admissions keys to be loaded in the user profile
# Causes a dialog from Gpg4win (or Kleopatra) to open requesting the password for the private key
# Returns the file location of the decrypted file, or -1 if decryption failed
# gpg really didn't like the network paths. Copied files locally processed, moved and deleted
function decrypt($in){
	Copy-Item $in .;
	$file = ([System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileNameWithoutExtension($in)) + ".txt");
    $outfile = $DECFILE_PATH + "\" + [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetFileNameWithoutExtension($in)) + ".txt" ;    
    try{
        gpg --output $file --keyring $env:APPDATA\gnupg\pubring.gpg --batch --yes  --passphrase $ENC_PASSPHRASE --decrypt ([System.IO.Path]::GetFileName($in));
		Move-Item $file $outfile;
		Remove-Item ([System.IO.Path]::GetFileName($in)) -Force;
        return $outfile;
    }
    catch {
        return "-1";
    }
}

function main(){
    $pearsonFile = "-1";
    $pre = ""; # We use pearsonFile for the file location; pre is the previous value
    $dsn = getPearsonFileName (Get-Date ((Get-Date).addDays(-1).ToShortDateString())); #Check for yesterday's file
    $pearsonFile = getPearsonFile $dsn $PEARSON_UID $PEARSON_PWD;
	if($got -NE "-1"){
		$pre = $pearsonFile;
		$pearsonFile = decrypt "${pearsonFile}";

		if($pearsonFile -NE "-1"){
			$pre = $pearsonFile;
			$pearsonFile = createCSV $pearsonFile ($CSVFILE_PATH +"\" + [System.IO.Path]::GetFileNameWithoutExtension($got) + ".csv");
			if($pearsonFile -NE "-1"){
				Remove-Item $pre -Force;
			}
		}
	}
	return $got
}
