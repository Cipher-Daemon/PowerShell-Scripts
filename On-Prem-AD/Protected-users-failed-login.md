```powershell
$data = @()
$Events = Get-WinEvent -FilterHashtable @{LogName = 'Microsoft-Windows-Authentication/ProtectedUserFailures-DomainController';id = '100'}
foreach ($Event in $Events){
    $Username = ($Event|select -ExpandProperty properties)[0]
    $DeviceName = ($Event|select -ExpandProperty properties)[1]
    $Row = ''|select UserName,DeviceName
    $Row.Username = $Username.value
    $Row.DeviceName = $DeviceName.value
    $Data += $Row
}

$Data|group -Property Username,devicename|select name, count
```
