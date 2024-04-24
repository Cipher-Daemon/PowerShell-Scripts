# Compare Hash
```powershell
#This will compare the hashes that you download from the internet and the one generated by you to ensure the hashes matches without human error

 function TestRegEx{
    if ($HashRegEx -eq $false) {Write-host -ForegroundColor red "NOT A VALID HASH! PLEASE TRY AGAIN!"}
    }

$TestPath = $Null
while ($TestPath -ne $True){
$FilePath = read-host -prompt "What is the full file path?"
$FilePath = $FilePath.Trim([char]0x0022)
$TestPath = Test-Path -Path $FilePath
if ($TestPath -eq $False){
    Write-host -ForegroundColor red "PATH TO FILE IS EITHER INVALID OR IT DOES NOT EXIST, PLEASE TRY AGAIN!"
    }
}

$i = 0
$HashRegEx = $null
while (($i -ne 1) -or ($HashRegEx -ne $True)){
$OriginalHash = read-host -prompt "What is the hash provided?"
$OriginalHash = $OriginalHash.Trim()

switch ($OriginalHash.length){
    32 {$HashAlgorithm = "md5";$i = 1;$HashRegEx = $OriginalHash -match '[A-Fa-f0-9]{32}';TestRegEx}
    40 {$HashAlgorithm = "sha1";$i = 1;$HashRegEx = $OriginalHash -match '[A-Fa-f0-9]{40}';TestRegEx}
    64 {$HashAlgorithm = "sha256";$i = 1;$HashRegEx = $OriginalHash -match '[A-Fa-f0-9]{64}';TestRegEx}
    128 {$HashAlgorithm = "sha512";$i = 1;$HashRegEx = $OriginalHash -match '[A-Fa-f0-9]{128}';TestRegEx}
    default {Write-host -ForegroundColor red "NOT A VALID HASH! PLEASE TRY AGAIN!"}
    }
}

$MyHash = get-filehash -algorithm $HashAlgorithm $FilePath

write-host "Vendor hash is: $OriginalHash"
write-host "Your hash is:" $MyHash.Hash

if($OriginalHash -eq $MyHash.Hash) {
    Write-Host "Match" -BackgroundColor black -ForegroundColor Cyan
} else {
    write-host "No Match" -BackgroundColor black -ForegroundColor Red
}
write-host "Algorithm used: $HashAlgorithm"

```