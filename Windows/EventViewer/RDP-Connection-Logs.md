```powershell
$Data = @()

$Events = get-winevent -FilterHashtable @{Logname = 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational'; id = '1149'}

$Events|select -ExpandProperty properties|select -ExpandProperty value

foreach ($event in $Events){
    $Row = ""|Select TimeGenerated,Username,Domain,SourceIP
    $Row.TimeGenerated = $event.TimeCreated.ToString("yyyy/MM/dd HH:mm:ss K")
    $Row.Username = ($event|select -ExpandProperty properties|select -ExpandProperty value)[0]
    $Row.domain = ($event|select -ExpandProperty properties|select -ExpandProperty value)[1]
    $Row.SourceIP = ($event|select -ExpandProperty properties|select -ExpandProperty value)[2]
    $Data += $Row
}

$Data
```
