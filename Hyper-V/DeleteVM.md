```powershell
$vmname = read-host -prompt "VMName"
$vm = Get-VM -Name $vmName
$vhds = Get-VMHardDiskDrive -VMName $vmName
Remove-VM -VM $vm -Force

foreach ($vhd in $vhds) {
    $vhdPath = $vhd.Path
    Remove-Item -Path $vhdPath -Force
    Write-Host "Deleted virtual hard disk: $vhdPath"
}
```
