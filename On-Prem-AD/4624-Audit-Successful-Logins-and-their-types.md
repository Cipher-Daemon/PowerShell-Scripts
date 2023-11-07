# Audit Successful Login And Their Types

This script will go through the security log and search the 4624 event id and puts it out in a readable grid, this can be useful for seeing if accounts still use NTLM if you decide to disable NTLM in your environment.

```powershell
$data = @()
$Events = Get-WinEvent -FilterHashtable @{LogName = 'Security';id = '4624'}


foreach ($Event in $Events){
    $info = $Null
    $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
    $TargetUserName = ($Event|select -ExpandProperty properties)[5]
    $LogonType = ($Event|select -ExpandProperty properties)[8]
    $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
    $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
    $WorkstationName = ($Event|select -ExpandProperty properties)[11]
    $IPAddress = ($Event|select -ExpandProperty properties)[18]
    $Row = ''|select SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
    $Row.SubjectUserName = $SubjectUserName.Value
    $Row.TargetUserName = $TargetUserName.value
    $Row.LogonType = $LogonType.value
    $Row.LogonProcessName = $LogonProcessName.value
    $Row.AuthenticationPackageName = $AuthenticationPackageName.value
    $Row.WorkstationName = $WorkstationName.value
    $Row.IPAddress = $IPAddress.value
    $Data += $Row
}

$Data|Out-Gridview
```
