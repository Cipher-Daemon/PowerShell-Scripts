# Top Senders

https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailtrafficsummaryreport?view=exchange-ps

Show Top 5 Senders in the past day:
```powershell
(Get-MailTrafficSummaryReport -Category TopMailSender -StartDate (get-date).adddays(-1) -EndDate (get-date)|select C1,C2)[0..4]
```

Check Top Senders in the past 2 weeks

```powershell
Connect-ExchangeOnline
[int]$Days = 0
$Report = @()

while ($days -ne -14){
$Day = (get-date).adddays($Days).ToString('yyyy-MM-dd')
$TopSenders = (Get-MailTrafficSummaryReport -Category TopMailSender -StartDate (get-date).adddays($Days) -EndDate (get-date).adddays($Days)|select C1,C2)
    foreach ($TopSender in $TopSenders){
        $Row = ''|select Day, Sender, Count
        $Row.Day = $Day
        $Row.Sender = $TopSender.C1
        [int]$Row.Count = $TopSender.C2
        $Report += $Row
        }

    $Days--
}

$Report|sort count -descending|Out-GridView
```
