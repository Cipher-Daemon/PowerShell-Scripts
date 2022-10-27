#Requires -RunAsAdministrator
#Prerequisite: you must have the OU path and Text file available ahead of time prior to running this script

$FilePath = read-host -prompt "File to read from (Include full file path)."
$FinalPath = Read-host -prompt "Full OU Path to move machines to (No quotes)."
$Computers = get-content -path $FilePath
$ErrorActionPreference= 'silentlycontinue'

foreach ($Computer in $Computers){
    $Machine = (get-adcomputer -Identity $Computer -errorvariable NoComputer).DistinguishedName
    if ($NoComputer){
        write-host -foregroundcolor red "Computer $Computer does not exist! Skipping."
    }else{
        move-adobject -Identity $Machine -targetpath $FinalPath
        write-host -ForegroundColor Green "Computer $computer has been moved!"
        }
    
}
