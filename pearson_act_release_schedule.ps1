<#
.SYNOPSIS
    Mappings of variations in the scheduled release of ACT scores 
    outside of the regular.
.NOTES
    Full Name: pearson_act_release_schedule.ps1
    Author: Shane O'Malley-Potting - shane.omalley-potting@uwrf.edu
    Values will need to be updated annually
#>
$schedule = @{
    <#
        Static dates for Holidays: 12/24, 12/25, 1/1, 7/4
        Weekday Holidays: Day after Thanksgiving (Nov), MLK Day (Jan), Memorial Day (May). Labor Day is in a blackout period between August and September
	Unlisted holiday for the lack of national test in August
    #>
	"holidays" = @((Get-Date "10-20-2018"),(Get-Date "11-23-2018"),(Get-Date "12-24-2018"),(Get-Date "12-25-2018"),(Get-Date "01-01-2019"),(Get-Date "07-04-2019"), (Get-Date "01-21-2019"), (Get-Date "05-27-2019"), (Get-Date "08-17-2019"));    <#
        National Test Day results in odd months
    #>
    "special_runs" = @((Get-Date "09-15-2018"),(Get-Date "07-20-2019"), (Get-Date "11-10-2018"));
	"start_date" = "09/05/2018";
	"start_code" = 81110
};

function run_scheduled_test($date, $holidays, $specials){
    $scheduled = $false;
    if($date -NotIn $holidays){ # Not processed on observed holidays
        if($date.DayOfWeek -IN @(1,3,5)){ # Processed on M-W-F
            $scheduled = $true;
        } 
        elseif ($date.DayOfWeek -EQ 6 -AND $date.Month % 2 -EQ 0 -AND $date.Day -GT 14 -AND $date.Day -LE 21){ # Processed every other month on the 3rd Saturday
            $scheduled = $true;
        }
        elseif($date -IN $specials){ # Sometimes it is ran specially
            $scheduled = $true;
        }
    }
    return $scheduled;
}

function getPearsonFileName_test($previous, $start, $number){
    $start = [DateTime]$start;
    Write-Output($start);
    $end_date = $start; # Changing variable
    $now = $previous; # The date to check
    Write-Output($now);
    $inc = 0;
    while($start -LE $now){ # Iterate days since the first pair until now
                if(run_scheduled_test $start $schedule.holidays $schedule.special_runs){ # If it is applicable, increment, and set the temporary date variable
            Write-Output("C" + ($number + (10 * ($inc -1))) + " " +  $start);
            $end_date = $start;
            $inc++;
        }
        $start = $start.addDays(1); # Check the next day
    }	
    return ("C" + ($number + (10 * ($inc -1)))); # Do the math, and it adds one extra by accident. 
}
$test = $false;

if($test){
    getPearsonFileName_test (Get-Date "09-01-2019") $schedule.start_date $schedule.start_code;
}
