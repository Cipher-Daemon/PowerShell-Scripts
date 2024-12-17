# VM Commands

## Boot Methods

Set both VMs to start on net adapter

```powershell
$VMName = read-host -prompt "VMName";$VMAdapter = get-VMNetworkAdapter -VMName $VMName;Set-VMFirmware $VMName -FirstBootDevice $VMAdapter
```

```powershell
$VMAdapter = get-VMNetworkAdapter -VMName "win10";Set-VMFirmware "Win10" -FirstBootDevice $VMAdapter;$VMAdapter = get-VMNetworkAdapter -VMName "win11";Set-VMFirmware "Win11" -FirstBootDevice $VMAdapter
```

## VM Creation

To create a VM that is Generation 2, with 8GB of memory, VHDX is 60GB and starting processor count is 4:
```powershell
$VMName = read-host -prompt "VMName?";new-vm -name $VMName -MemoryStartupBytes 8GB -path "C:\Hyper-v\vm" -newVHDPath "C:\Hyper-v\Disk\$VMName.vhdx" -newVHDSizeBytes 60GB -generation 2 -switchname "MDT";set-vm -Name $VMName -ProcessorCount 4
```

## Networking

Tell the VM to use a specific switch:
```powershell
Get-VMNetworkAdapter -vmname $VMName|Connect-VMNetworkAdapter -SwitchName Isolated-Network
```

## VM-Snapshot

To Create a snapshot:

```powershell
Checkpoint-VM -name [VM-NAME] -SnapshotName [SNAPSHOT-NAME]
```

Restore From snapshot

```powershell
Restore-VMSnapshot -VMName [VM-NAME] -name [SNAPSHOT-NAME] -Confirm:$false
```

Set to Standard (In Current State and running):

```powershell
set-vm -Name [VM-NAME] -CheckpointType Standard
```
Check snapshot:

```powershell
Get-VMsnapshot -VMName [VM-NAME]
```
Delete checkpoint/snapshot

```powershell
Remove-VMsnapshot -VMName [VM-NAME] -Name [CHECKPOINT-NAME]
```

## DVD Drive

For GEN 2 machines to add DVD Drive and mount ISO file
```powershell
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia
```

To add/attach DVD Drive

```powershell
Set-VMDvdDrive -VMName $VMName -Path $InstallMedia
```

To detatch/unmount ISO File 

```powershell
Get-VMDvdDrive -VMName $VMName | Set-VMDvdDrive -Path $null
```
## VHD

To set VHDX file to minimum size

```powershell
Resize-VHD -Path c:\BaseVHDX.vhdx -ToMinimumSize
```

Reclaim zero bytes of free space

```powershell
Optimize-VHD -Path c:\test\dynamic.vhdx -Mode Full
```

Reclaim all disk in an array (Note: VM's must be turned off)

```powershell
$Disks = (get-childitem -Recurse -Path C:\Hyper-v\Disk\|?{$_.Extension -eq ".vhdx"}).fullname

foreach ($Disk in $Disks){
Optimize-VHD -Path $disk -Mode Full
}
```
