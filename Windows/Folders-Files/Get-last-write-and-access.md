```powershell
$Baseline = (get-date -year 2023 -month 11 -day 14 -hour 00 -Minute 00 -Second 00)
#$DirectoryToScan = read-host "Path to scan?"
#$DirectoryToScan = $DirectoryToScan.Trim([char]0x0022)


while ($True){
    $DirectoryToScan = read-host "Path to scan?"

    if($DirectoryToScan -eq $Null -or $DirectoryToScan -eq ''){
        write-host -ForegroundColor red "Variable path is set to Null! Please change the variable to a valid path!"
    }

    elseif (Test-Path $DirectoryToScan){
    break
    }
    else {
    write-host -ForegroundColor red "PATH TO SCAN IS EITHER INVALID, DOES NOT EXIST OR OTHER TOOLS ARE PREVENTING FROM SCANNING!"
    }

}


$ExportPath = read-host "Path to save the export (PLEASE INCLIDE CORRECT PATH AND .CSV AT THE END!)"
$ExportPath = $ExportPath.Trim([char]0x0022)


$AllItems = get-childitem -Recurse $DirectoryToScan |?{$_.lastwritetime -ge $Baseline -or $_.LastAccessTime -ge $Baseline}


function ScanDrive {
$data = @()
foreach ($Item in $AllItems){

    if ($Item.PSIsContainer -eq $True){
        $Itemtype = 'Directory'
        }else{
            $Itemtype = 'File'
        }        


    [datetime]$TimeGeneratedAccess = $Item.lastaccesstime
    [datetime]$TimeGeneratedLastWrite = $Item.Lastwritetime
    $Fullname = $Item.fullname
    $Row = ''|Select ItemType,FullPath,LastAccessTime,LastWriteTime
    $Row.ItemType = $Itemtype
    $Row.FullPath = $Fullname
    $Row.LastAccessTime = $TimeGeneratedAccess
    $Row.LastWriteTime = $TimeGeneratedLastWrite

    $Data += $Row


}
    $Data|Export-Csv -NoTypeInformation -Path $ExportPath
}

if($DirectoryToScan -eq $Null -or $DirectoryToScan -eq ''){
    write-host -ForegroundColor red "Variable path is set to Null! Please change the variable to a valid path!"
}
elseif (Test-Path $DirectoryToScan){
    ScanDrive
}
else {
    write-host -ForegroundColor red "PATH TO SCAN IS EITHER INVALID, DOES NOT EXIST OR OTHER TOOLS ARE PREVENTING FROM SCANNING!"
}


if (Test-Path $ExportPath){
    write-host -ForegroundColor Cyan "CSV File has been successfully exported, you may now open $ExportPath !"
   }else{
    Write-Host -ForegroundColor Red "Something went wrong while validating the exported CSV file path!"
    }





```
