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
	"holidays" = @((Get-Date "09-04-2017"),(Get-Date "10-21-2017"),(Get-Date "11-24-2017"), (Get-Date "12-25-2017"), (Get-Date "01-01-2018"), (Get-Date "01-15-2018"), (Get-Date "09-01-2018"), (Get-Date "05-28-2018"), (Get-Date "07-04-2018"));;
	"special_runs" = @((Get-Date "09-16-2017"),(Get-Date "11-11-2017"), (Get-Date "07-21-2018"));
	"start_date" = "09/06/2017";
	"start_code" = 71110
};
