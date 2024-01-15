```powershell
cls
$Prompt = 0
$IsCorrect = $Null
while (($Prompt -ne "1") -or ($Prompt -ne "2") -or ($Prompt -ne "3")){
    $prompt = read-host "Do You Want To Reboot: 
On A Specific Day (1)
Specific Day And Time (2)
Or Max (10 years) (3)
    
Prompt"
    if ($Prompt -eq 1 -or $Prompt -eq 2 -or $Prompt -eq 3){
        }else{Write-host -ForegroundColor red "NOT A VALID OPTION!"}

    switch ($Prompt){
        1 {write-host -foregroundcolor Cyan "You Have Chosen Specific Day!"}
        2 {write-host -foregroundcolor Cyan "You Have Chosen Specific Day And Time!"}
        3 {write-host -ForegroundColor Cyan "You have chosen to reboot in 10 years!"}
    }

    if (($Prompt -eq "1") -or ($Prompt -eq "2") -or ($Prompt -eq "3")){
    $IsCorrect = read-host "Is this correct?"
    }


    if($IsCorrect -eq "Y" -or $IsCorrect -eq "Yes"){
    break}
}


function ExactDay{
$YOR = read-host "Year to reboot (YYYY)"
$MOR = read-host "Month to reboot (MM)"
$DOR = read-host "Day to reboot (DD)"
$FinalReboot = Get-Date -Year $YOR -Month $MOR -Day $DOR -Hour 00 -Minute 00 -Second 00

$TimeToReboot = (New-TimeSpan -Start (get-date).DateTime -end $FinalReboot).TotalSeconds



$TimeToReboot = [int][math]::floor($TimeToReboot)

cmd.exe "shutdown /r /t $TimeToReboot"
}

function ExtactDayandTime{
$YOR = read-host "Year to reboot (YYYY)"
$MOR = read-host "Month to reboot (MM)"
$DOR = read-host "Day to reboot (DD)"
$HOR = read-host "Hour to Reboot (24 hour format)"
$MinOR = read-host "Minute to reboot (MM)"
$FinalReboot = Get-Date -Year $YOR -Month $MOR -Day $DOR -Hour $HOR -Minute $MinOR -Second 00

$TimeToReboot = (New-TimeSpan -Start (get-date).DateTime -end $FinalReboot).TotalSeconds



$TimeToReboot = [int][math]::floor($TimeToReboot)

cmd.exe "shutdown /r /t $TimeToReboot"

}





switch ($Prompt){
    1 {ExactDay}
    2 {ExtactDayandTime}
    3 {shutdown.exe /r /t 315359999}
}
```
