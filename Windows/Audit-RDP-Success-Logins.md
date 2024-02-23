# Audit RDP Successful Logins

```powershell
$Data = @()


$Events = Get-WinEvent -FilterHashtable @{
logname = 'Microsoft-Windows-TerminalServices-LocalSessionManager/Operational'
id = 21
}


foreach ($Event in $Events){
$Time = ($Event.timecreated).tostring("yyyy-MM-dd HH:mm")
$UserID = ($Event|select -ExpandProperty properties).value[0]
$Sourcemachine = ($Event|select -ExpandProperty properties).value[2]

$Row = ''|Select Time,UserID,SourceMachine
$Row.Time = $Time
$Row.UserID = $UserID
$Row.SourceMachine = $SourceMachine
$Data += $Row
}


$Data
```
