```powershell
$Events = get-winevent -FilterHashtable @{Logname='Microsoft-Windows-AppLocker/EXE and DLL';id=8003}

$Data = @()

foreach ($event in $Events){
$FullPath = ($Event|select -ExpandProperty properties)[17]
$Row = ''| select FullPath
$Row. Fullpath = $FullPath.value
$Data += $Row
}

$Data | group -Property FullPath| select name, count
```
