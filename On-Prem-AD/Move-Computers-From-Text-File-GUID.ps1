#prerequisite: you must have the OU path and Text file available ahead of time prior to writing this script

$FilePath = read-host -prompt "File to read from (Include full file path)."
$FinalPath = Read-host -prompt "Full OU Path to move machines to (No quotes)."
$FinalPathGUID = ((get-adobject -Identity $FinalPath).objectGUID).GUID
$Computers = get-content -path $FilePath
$ErrorActionPreference= 'silentlycontinue'

foreach ($Computer in $Computers){
    $Machine = (get-adcomputer -Identity $Computer -errorvariable NoComputer).ObjectGUID
    if ($NoComputer){
        write-host -foregroundcolor red "Computer $Computer does not exist! Skipping."
    }else{
        move-adobject -Identity $Machine -targetpath $FinalPathGUID
        write-host -ForegroundColor Green "Computer $computer has been moved!"
        }
    
}
