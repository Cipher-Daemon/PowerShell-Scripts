# Successful Logins

## Types of logins that Microsoft logs

Source: https://learn.microsoft.com/en-us/windows-server/identity/securing-privileged-access/reference-tools-logon-types

|Logon ID|Logon Type|Authenticators Accepted|Reusable Credentials in LSA Session|Example(s)|
|---|---|---|---|---|
|2|Interactive (also known as, Logon locally)|Password, Smartcard,other|Yes|Console logon;<br />RUNAS;<br />Hardware remote control solutions (such as Network KVM or Remote Access / Lights-Out Card in server)<br />IIS Basic Auth (before IIS 6.0)|
|3|Network|Password, NT Hash, Kerberos ticket|No, unless if delegation is present then kerberos tickets are present|NET USE;<br />RPC calls;<br />Remote registry;<br />IIS integrated Windows auth;<br />SQL Windows auth;|
|4|Batch|Password (stored as LSA secret)|Yes|Scheduled tasks|
|5|Service|Password (stored as LSA secret)|Yes|Windows Service|
|8|NetworkCleartext|Password|Yes|IIS Basic Auth (IIS 6.0 and newer);<br />Windows PowerShell with CredSSP|
|9|NewCredentials|Password|Yes|RUNAS /NETWORK
|10|RemoteInteractive|Password, Smartcard, other|Yes|Remote Desktop (Also known as "Terminal Services")|

## Replacement Strings
|Array Position|Data Type|Confirmed|
|---|---|---|
|0|Security ID|Yes|
|1|Account Name|Yes|
|2|Account Domain|Yes|
|3|Logon ID (Subject)|Yes|
|4|Security ID|Yes|
|5|Account Name|Yes|
|6|Account Domain|Yes|
|7| Logon ID (New Logon)|Yes|
|8|Logon Type|Yes|
|9|Logon Process|Yes|
|10|Authentication Package|Yes|
|11|Workstation Name|UNKNOWN|
|12|Logon GUID|Yes|
|13|UNKNOWN|UNKNOWN|
|14|Package Name (NTLM only)|Yes|
|15|Key Length|Yes|
|16|Process ID|Yes|
|17|Process Name|Yes|
|18|Source Network Address|Yes|
|19|Source Port|Yes|
|20|Impersonation Level|Yes|
|21|UNKNOWN|UNKNOWN|
|22|UNKNOWN|UNKNOWN|
|23|UNKNOWN|UNKNOWN|
|24|Virtual Account or Elevated Token|UNKNOWN|
|25|Linked Logon ID|Yes
|26|Virtual Account or Elevated Token|UNKNOWN|

## Powershell The Audit Log

The Event ID for successful logins is 4624 in the security log, to get all the successful logins you use the following:

```powershell
Get-EventLog -LogName Security -InstanceId 4624
```
### Examples
To filter the successful logins for a specific Logon ID as specified from the table above we use the following syntax:

#### To Filter Only Interactive Logins (ID 2):
```powershell
Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 2}
```
#### To Filter Only Remote Desktop Logins (ID 10):
```powershell
Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 10}
```
#### To Filter Successful Interactive Logins For A Specific User
```powershell
$FilterUser = '*Admin*'
Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 2 -and $_.replacementstrings[5] -like $FilterUser}
```
#### Show Times When a User RDP Into A Workstation
```powershell
$Events = Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 3}

foreach ($Event in $Events){
write-host "On "$Event.Timegenerated" the computer "$Event.replacementstrings[6]" was signed in under the account "$Event.replacementstrings[5]" from IP "$Event.replacementstrings[18]"!"
}
```
