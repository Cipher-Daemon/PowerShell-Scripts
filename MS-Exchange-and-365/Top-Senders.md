# Top Senders

https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailtrafficsummaryreport?view=exchange-ps

Show Top 5 Senders in the past day:
```powershell
(Get-MailTrafficSummaryReport -Category TopMailSender -StartDate (get-date).adddays(-1) -EndDate (get-date)|select C1,C2)[0..4]
```
