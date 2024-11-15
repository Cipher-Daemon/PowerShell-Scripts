# Set both VMs to start on net adapter

```powershell
$VMName = read-host -prompt "VMName";$VMAdapter = get-VMNetworkAdapter -VMName $VMName;Set-VMFirmware $VMName -FirstBootDevice $VMAdapter
```

```powershell
$VMAdapter = get-VMNetworkAdapter -VMName "win10";Set-VMFirmware "Win10" -FirstBootDevice $VMAdapter;$VMAdapter = get-VMNetworkAdapter -VMName "win11";Set-VMFirmware "Win11" -FirstBootDevice $VMAdapter
```

# Create New VM

```powershell
$VMName = read-host -prompt "VMName?";new-vm -name $VMName -MemoryStartupBytes 8GB -path "C:\Hyper-v\vm" -newVHDPath "C:\Hyper-v\Disk\$VMName.vhdx" -newVHDSizeBytes 60GB -generation 2 -switchname "MDT";set-vm -Name $VMName -ProcessorCount 4
```

# Optional

```powershell
#Get-VMNetworkAdapter -vmname $VMName|Connect-VMNetworkAdapter -SwitchName Isolated-Network
```

# VM-Snapshot

## Create

```powershell
Checkpoint-VM -name [VM-NAME] -SnapshotName [SNAPSHOT-NAME]
```

## Restore

```powershell
Restore-VMSnapshot -VMName [VM-NAME] -name [SNAPSHOT-NAME] -Confirm:$false
```

## Set to Standard (In Current State and running)

```powershell
set-vm -Name [VM-NAME] -CheckpointType Standard
```
## Check

```powershell
Get-VMCheckpoint -VMName [VM-NAME]
```
## Delete checkpoint

```powershell
Remove-VMCheckpoint -VMName [VM-NAME] -Name [CHECKPOINT-NAME]
```
