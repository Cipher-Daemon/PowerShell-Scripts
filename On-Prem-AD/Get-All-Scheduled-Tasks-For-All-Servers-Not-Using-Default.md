# Get all scheduled task not running as default users

```powershell
$ErrorActionPreference= 'silentlycontinue'
$ActiveServers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} -Properties LastLogonDate |Where-Object {($_.LastLogonDate -gt (Get-Date).AddDays(-30))}
$ActiveServers = $ActiveServers.name
foreach ($Server in $ActiveServers){
    $Tasks = Get-ScheduledTask -cimsession $Server -ErrorVariable ServerError
    if ($serverError){
        write-host -ForegroundColor Red "Server error, needs to run on $Server manually!"
        }
    foreach ($Task in $Tasks){
        if ($task.Principal.UserId -ne $Null -and $task.Principal.UserId -ne "SYSTEM" -and $task.Principal.UserId -ne "NETWORK SERVICE" -and $task.Principal.UserId -ne "LOCAL SERVICE"){
            $taskPath = $task.TaskPath
            $taskname = $task.taskname
            $runAs = $task.Principal.UserId
            Write-Host "Task Path: $taskPath"
            Write-host "Task Name: $Taskname"
            Write-Host "RunAs: $runAs"
            Write-host "Server: $Server"
            Write-Host "---"
        }else{

        }
    }
}
```
