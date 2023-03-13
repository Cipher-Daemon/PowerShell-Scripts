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
|Array Position|Data Type|
|---|---|
|0|Security ID|
|1|Account Name|
|2|Account Domain|
|3|Logon ID (Subject)|
|4|Security ID|
|5|Account Name|
|6|Account Domain|
|7|Logon ID (New Logon)|
|8|Logon Type|
|9|Logon Process|
|10|Authentication Package|
|11|Workstation Name|
|12|Logon GUID|
|13|Transmitted Services|
|14|Package Name (NTLM only)|
|15|Key Length|
|16|Process ID|
|17|Process Name|
|18|Source Network Address|
|19|Source Port|
|20|Impersonation Level|
|21|Restricted Admin Mode|
|22|Target Outbound User Name|
|23|Target Outbound Domain Name|
|24|Virtual Account|
|25|Linked Logon ID|
|26|Elevated Token|

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
#### To Filter Only Remote Desktop/Terminal Services Logins (Results May Vary):
```powershell
Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 10}
```
#### To Filter Successful Interactive Logins For A Specific User
```powershell
$FilterUser = '*Admin*'
Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 2 -and $_.replacementstrings[5] -like $FilterUser}
```
#### Show Times When a User Signed Into A Workstation From Network
```powershell
$Events = Get-EventLog -LogName Security -InstanceId 4624|?{$_.replacementstrings[8] -eq 3}

foreach ($Event in $Events){
write-host "On "$Event.Timegenerated" the computer "$Event.replacementstrings[6]" was signed in under the account "$Event.replacementstrings[5]" from IP "$Event.replacementstrings[18]"!"
}
```
