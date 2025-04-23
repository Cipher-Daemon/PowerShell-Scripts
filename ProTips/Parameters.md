Example of mandatory parameters

## Example 1
```powershell
param([Parameter(Mandatory)]$CID, [Parameter(Mandatory)]$TID, [Parameter(Mandatory)]$CS)

write-host "ClientID $CID"
write-host "TenantID $TID"
write-host "ClientSecret $CS"
```

Command to run the above:

```powershell
.\shellscript.ps1 -CID "CID-tag" -TID "TID-Tag" -CS "Cs-Tag"
```

will result in:

```powershell
ClientID CID-tag
TenantID TID-Tag
ClientSecret Cs-Tag
```

## Example 2

```powershell
param ([int] $anInt, $maybeanInt)
```

parameter `anInt` would need to contain intiger numbers
