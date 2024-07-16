```powershell
$Data = Get-WinEvent -FilterHashtable @{LogName = 'Security';id = '4625'}
$Log = @()


foreach ($Event in $Data){
    $Account = (($Event|select -ExpandProperty properties).value)[5]
    $logontype = (($Event|select -ExpandProperty properties).value)[10]
    $logonprocessname = (($Event|select -ExpandProperty properties).value)[11]
    $processname = (($Event|select -ExpandProperty properties).value)[18]
    $Row = ''|select Account,logontype,logonprocessname,processname
    $Row.Account = $Account
    $Row.logontype = $logontype
    $Row.logonprocessname = $logonprocessname
    $Row.processname = $processname
    $Log += $Row
}

$Log
```
