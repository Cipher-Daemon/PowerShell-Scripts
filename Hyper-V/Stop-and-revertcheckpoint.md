# Stop, Revert Snapshot and Start VM


## Get VM Name
In order for this to happen you must first get the name of your VM by using:

```powershell
get-vm
```

Example:
```
Name                       State   CPUUsage(%) MemoryAssigned(M) Uptime           Status             Version
----                       -----   ----------- ----------------- ------           ------             -------
RDP-Workstation            Running 1           8192              00:03:07.0560000 Operating normally 9.0
```

Note the name of the VM

## Get The Snapshot

Run the following Command

```powershell
Get-VMSnapshot -VMName "RDP-Workstation"
```

Result:
```
VMName          Name                 SnapshotType CreationTime         ParentSnapshotName
------          ----                 ------------ ------------         ------------------
RDP-Workstation No-Software          Standard     6/2/2023 12:14:05 PM
```

## The Magic One Liner

Putting it all together

```powershell
stop-vm -name "RDP-workstation" -TurnOff;Restore-VMSnapshot -name 'No-Software' -VMName "RDP-Workstation" -Confirm:$false;start-vm -name "RDP-workstation"
```
