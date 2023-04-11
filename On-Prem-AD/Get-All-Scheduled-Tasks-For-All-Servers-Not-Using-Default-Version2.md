# Get all scheduled task not running as default users Version 2

```powershell

$data = @()
$NoServers = @()
$ErrorActionPreference= 'silentlycontinue'
$ActiveServers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} -Properties LastLogonDate |Where-Object {($_.LastLogonDate -gt (Get-Date).AddDays(-30))}
$ActiveServers = $ActiveServers.name
foreach ($Server in $ActiveServers){
    $Tasks = Get-ScheduledTask -cimsession $Server -ErrorVariable ServerError
    if ($serverError){
        write-host -ForegroundColor Red "Server error, needs to run on $Server manually!"
        $NoServers += $Server
        }
    foreach ($Task in $Tasks){
        if ($task.Principal.UserId -ne $Null -and $task.Principal.UserId -ne "SYSTEM" -and $task.Principal.UserId -ne "NETWORK SERVICE" -and $task.Principal.UserId -ne "LOCAL SERVICE"){
            $taskPath = $task.TaskPath
            $taskname = $task.taskname
            $runAs = $task.Principal.UserId
            $Row = "" | Select TaskPath,TaskName,RunAs,Server
            $Row.TaskPath = $taskPath
            $Row.TaskName = $taskname
            $Row.RunAs = $Runas
            $Row.Server = $Server
            $Data += $Row
            }else{

        }
    }
}

if ($NoServers.count -eq 0){
    write-host -ForegroundColor Cyan "No Servers returned any errors!"
    Start-Sleep -Seconds 3
    }else{
    write-host -ForegroundColor Red "$NoServers.count Servers were not able to run this PS command remotely, need to run them on the servers themselves:"
    write-host ""
    write-host "$NoServers"
    write-host ""
    write-host "Press the enter key to contunue..."
    read-host
    }

$data|sort runas,server

```

# For Standalone script to run on a single server

```powershell
$data = @()
$ErrorActionPreference= 'silentlycontinue'

    $Tasks = Get-ScheduledTask 
    foreach ($Task in $Tasks){
        if ($task.Principal.UserId -ne $Null -and $task.Principal.UserId -ne "SYSTEM" -and $task.Principal.UserId -ne "NETWORK SERVICE" -and $task.Principal.UserId -ne "LOCAL SERVICE"){
            $taskPath = $task.TaskPath
            $taskname = $task.taskname
            $runAs = $task.Principal.UserId
            $Row = "" | Select TaskPath,TaskName,RunAs,Server
            $Row.TaskPath = $taskPath
            $Row.TaskName = $taskname
            $Row.RunAs = $Runas
            $Row.Server = $Server
            $Data += $Row
            }else{

        }
    }


$data|sort runas,server
```
