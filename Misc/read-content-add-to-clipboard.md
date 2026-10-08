```powershell
cls
$FolderPath = Read-host "File Path Location: "
$FolderPath = $FolderPath.Trim([char]0x0022)

$AllFiles = get-childitem -Path $FolderPath|?{$_.Extension -eq ".txt"}

$Appendlist = $Null
[int]$i = 1
[int]$x = 0

foreach ($File in $AllFiles){
    cls
    
    get-content -path $File.fullname
    [int]$total = $($AllFiles.count)
    $Percentage = [math]::Round(($i / $Total) * 100,2)

    write-host -ForegroundColor Cyan "Save $($File.name) name to Append List? ($i out of $Total remaining.) $Percentage % Complete."
    $Response = read-host "Yes or No? "

    switch ($Response){
        y {write-host -ForegroundColor Magenta "Saving Result";start-sleep -Seconds 1;$Appendlist += "$($File.name)`n";$i++}
        yes {write-host -ForegroundColor Magenta "Saving Result";start-sleep -Seconds 1;$Appendlist += "$($File.name)`n";$i++}
        default {write-host -ForegroundColor Yellow "Not Saving Result!";start-sleep -Seconds 1;$i++}
    }

}

cls

write-host -ForegroundColor Yellow "Saving results to clipboard."
start-sleep -Seconds 3
$Appendlist|clip


$Appendlist = $Appendlist -split "`r?`n" |ForEach-Object { $_.Trim() } |Where-Object { $_ }|sort

$newdir = Join-Path -Path $FolderPath -ChildPath "ToCheck"
mkdir $newdir

write-host -ForegroundColor Yellow "Creating $Newdir to copy results to."


foreach ($File in $Appendlist){
    write-host -ForegroundColor green "Copying $File"
    $FullFilePath = Join-Path -Path $FolderPath -ChildPath $File
    Copy-Item -Path $FullFilePath -Destination $newdir


}
```
