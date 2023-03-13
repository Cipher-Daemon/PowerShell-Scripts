# Locked Out Accounts

## Event ID

The Event ID that is used for locked out accounts is 4740

```powershell
Get-EventLog -LogName Security -InstanceId 4740
```

## Replacement Strings
|Array Position| Data Type|
|---|---|
|0|Target User Name|
|1|Target Domain Name|
|2|Target SID|
|3|Subject User SID|
|4|Subject User Name|
|5|Subject Domain Name|
|6|Subject Logon ID|

## Powershell The Audit Log

### Examples

#### Show All Lockout Events For A Specific User
```powershell
$FilteredUser = '*admin*'
Get-EventLog -LogName Security -InstanceId 4740|?{$_.replacementstrings[0] -like $FilteredUser}
```
#### Show When And Where The User Account Was Locked Out
```powershell
$Events = Get-EventLog -LogName Security -InstanceId 4740

foreach ($Event in $Events){
write-host "On"$Event.timegenerated"the user account"$Event.replacementstrings[0]"was locked from"$Event.replacementstrings[1]"!"
}
```
