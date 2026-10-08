```powershell
cls
$FolderPath = Read-host "File Path Location: "
$FolderPath = $FolderPath.Trim([char]0x0022)

$AllFiles = (get-childitem -Path $FolderPath|?{$_.Extension -eq ".txt"}).basename

$AllList = (Read-Host "Machines to check against") -split "`r?`n" |ForEach-Object { $_.Trim() } |Where-Object { $_ }|sort

[int]$i = 0

foreach ($Computer in $AllList){

if ($Computer -notin $AllFiles){
    write-host -ForegroundColor Red "$Computer is missing!"
    $i++
    }else{
    #DO NOTHING
    }
}

if ($i -ne 0){
write-host -ForegroundColor Yellow "$i machine(s) missing total!"
}else{
write-host -ForegroundColor cyan "Nothing is missing!"
}

```
