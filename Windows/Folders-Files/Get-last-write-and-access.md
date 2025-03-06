```powershell
cls
$Baseline = (get-date -year 2023 -month 11 -day 14 -hour 00 -Minute 00 -Second 00)
$ErrorActionPreference = 'SilentlyContinue'
$DesktopPath = Join-Path $env:USERPROFILE "Desktop"
$ScanTime ='ScanResult-' + (get-date).ToString("yyyy-MM-dd_hh-mm-ss_tt")

while ($True){
    $DirectoryToScan = read-host "Path to scan?"
    $DirectoryToScan = $DirectoryToScan.Trim([char]0x0022)

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


$ExportPath = $ScanTime + '.csv'
$ExportPath = join-path $DesktopPath $ExportPath


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
    $Data|Export-Csv -NoTypeInformation -Path $ExportPath -ErrorAction SilentlyContinue
}

ScanDrive


if (Test-Path $ExportPath){
    write-host -ForegroundColor Cyan "CSV File has been successfully exported, you may now open $ExportPath !"
   }else{
    Write-Host -ForegroundColor Red "Something went wrong while validating the exported CSV file path, either it failed to validate or it does not exist!"
}
$ErrorActionPreference = 'Continue'
```
