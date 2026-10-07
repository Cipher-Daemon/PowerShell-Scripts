```powershell
$FolderPath = Read-host "File Path Location: "
$FolderPath = $FolderPath.Trim([char]0x0022)

$AllFiles = get-childitem -Path $FolderPath|?{$_.Extension -eq ".txt"}

$Appendlist = $Null
[int]$i = 1

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
        default {$i++}
    }

}


$Appendlist|clip
```
