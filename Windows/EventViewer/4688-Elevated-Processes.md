# 4688 - Elevated Processes

## Prerequisite

Must run the following command

```cmd
auditpol.exe /set /subcategory:"Process Creation" /failure:enable /success:enable
```

```powershell
$XMLFilter = "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and (EventID=4688)] and EventData[Data[@Name='TokenElevationType']='%%1937']]"

$Events = Get-WinEvent -LogName Security -FilterXPath $XMLFilter

$data = @()

foreach ($Event in $Events){
    $Time = ($Event.TimeCreated).ToString("yyyy/MM/dd HH:MM:ss")
    $User = (($Event|select -ExpandProperty properties)[1]).value
    $Process = (($Event|select -ExpandProperty properties)[5]).value
    $ParentProcess = (($Event|select -ExpandProperty properties)[13]).value
    $Row = ''|Select Time,User,Process,ParentProcess
    $Row.Time = $Time
    $Row.User = $User
    $Row.Process = $Process
    $Row.ParentProcess = $ParentProcess
    $Data += $Row
}

$Data
```

```powershell
$XMLFilter = "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and (EventID=4688)] and EventData[Data[@Name='TokenElevationType']='%%1937']]"

$Events = Get-WinEvent -LogName Security -FilterXPath $XMLFilter -ErrorVariable NoEvents -ErrorAction SilentlyContinue

function GetData{

$data = @()

foreach ($Event in $Events){
    $Time = ($Event.TimeCreated).ToString("yyyy/MM/dd HH:MM:ss")
    $User = (($Event|select -ExpandProperty properties)[1]).value
    $Process = (($Event|select -ExpandProperty properties)[5]).value
    $ParentProcess = (($Event|select -ExpandProperty properties)[13]).value
    $Row = ''|Select Time,User,Process,ParentProcess
    $Row.Time = $Time
    $Row.User = $User
    $Row.Process = $Process
    $Row.ParentProcess = $ParentProcess
    $Data += $Row
}

$Data
}

if ($NoEvents){
    Write-host "No events were found!"
    }else{
    GetData
    }
```

```powershell
$XMLFilter = "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and (EventID=4688)] and EventData[Data[@Name='TokenElevationType']='%%1937']]"

$Events = Get-WinEvent -LogName Security -FilterXPath $XMLFilter -ErrorVariable NoEvents -ErrorAction SilentlyContinue

function GetData{

$data = @()

foreach ($Event in $Events){
    $Time = ($Event.TimeCreated).ToString("yyyy/MM/dd HH:MM:ss")
    $ComputerName = hostname
    $User = (($Event|select -ExpandProperty properties)[1]).value
    $SubjectDomain = (($Event|select -ExpandProperty properties)[2]).value
    $Process = (($Event|select -ExpandProperty properties)[5]).value
    $ParentProcess = (($Event|select -ExpandProperty properties)[13]).value
    $Row = ''|Select Time,ComputerName,SubjectDomain,User,Process,ParentProcess
    $Row.Time = $Time
    $Row.ComputerName = $Computername
    $Row.SubjectDomain = $SubjectDomain
    $Row.User = $User
    $Row.Process = $Process
    $Row.ParentProcess = $ParentProcess
    $Data += $Row
}

$Data
}

if ($NoEvents){
    Write-host "No events were found!"
    }else{
    GetData
    }
```
