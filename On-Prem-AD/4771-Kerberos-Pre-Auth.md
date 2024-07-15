```powershell
$Data = Get-WinEvent -FilterHashtable @{LogName = 'Security';id = '4771';starttime=(get-date).adddays(-3)}
$Log = @()


foreach ($Event in $Data){
    $Account = (($Event|select -ExpandProperty properties).value)[0]
    $IP = (($Event|select -ExpandProperty properties).value)[6]
    $Code = (($Event|select -ExpandProperty properties).value)[4]
    $Row = ''|select Account,IP,Code
    $Row.Account = $Account
    $Row.IP = $IP
    $Row.Code = $Code
    $Log += $Row
}

$Log|group Account,IP,Code|select name,count|sort -Descending count
```

Codes can be listed here: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4771
