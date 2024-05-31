```powershell
$HostMachine = hostname
$Data = @()
$SMB1Logs = get-winevent -FilterHashtable @{
logname = 'Microsoft-Windows-SMBServer/Audit'
id = '3000'
}

foreach ($SMB1Entry in $SMB1Logs){
    $Client = $SMB1Entry.properties.Value
    $Row = ""|Select HostMachine, Client
    $Row.HostMachine = $HostMachine
    $Row.Client = $Client
    $Data += $Row
    }
$Data|group Client|select name,count|sort count -Descending
```
