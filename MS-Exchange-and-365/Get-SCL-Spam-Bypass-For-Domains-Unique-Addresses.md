# Get Unique Email Senders For Domains That Bypass Spam Filtering

This is mainly for passing `Ensure Spam confidence level (SCL) is configured in mail transport rules with specific domains` Secure Score.

Use this to check if there are unique email addresses that bypass spam filtering for the entire domain. Best practice is to not whitelist the entire domain, instead whitelist individual email senders.

Note with the command below you can set the `-startdate` to however many days and it wont error out but it will **ONLY** return the last 10 days of information.
 
```powershell
$Rules = (Get-TransportRule | Where-Object {($_.setscl -eq -1 -and $_.SenderDomainIs -ne $null)}).name

Get-MailDetailTransportRuleReport -StartDate (get-date).adddays(-10) -EndDate (get-date)|?{$_.transportrule -in $Rules}|group transportrule,senderaddress|select count,name|sort -Descending count
```
