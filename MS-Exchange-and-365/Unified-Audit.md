### List of usable operations for the Operations switch:

https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-log-activities?view=o365-worldwide#user-administration-activities


### Example of getting the all the AnonymousLinks used for the last 365 days:
```powershell

$RetriveOperation="AnonymousLinkUsed"

$result = Search-UnifiedAuditLog -StartDate ((get-date).adddays(-365)) -EndDate (get-date) -Operations $RetriveOperation -ResultSize 5000

$result|select-object -ExpandProperty Auditdata|ConvertFrom-Json

```

### Get logins for all the users in the last 30 days:

```powershell

$RetriveOperation="UserLoggedIn"

$result = Search-UnifiedAuditLog -StartDate ((get-date).adddays(-30)) -EndDate (get-date) -Operations $RetriveOperation -ResultSize 5000

$result|select-object -ExpandProperty Auditdata|ConvertFrom-Json

```

### To get around the 5000 result limitation:
(thanks to whoever wrote this snippit, credit goes to https://www.easy365manager.com/office-365-forensics-using-powershell-and-search-unifiedauditlog/)

Example below we want to get all the logs for the past 90 days that has logged Anonymous links being Removed, Created, Updadted & Used. While exporting the results to a CSV file.
```powershell

$OutputFile = "c:\temp\UnifiedAuditLog_FULL.csv"
$Today = Get-Date -Date (Get-Date -Format "yyyy-MM-dd")
$intDays = 90
$RetriveOperation = "AnonymousLinkRemoved,AnonymousLinkcreated,AnonymousLinkUpdated,AnonymousLinkUsed"
For ($i=0; $i -le $intDays; $i++){
  For ($j=23; $j -ge 0; $j--){
    $StartDate = ($Today.AddDays(-$i)).AddHours($j)
    $EndDate = ($Today.AddDays(-$i)).AddHours($j + 1)
    $Audit = Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -Operations $RetriveOperation -ResultSize 5000
    $ConvertAudit = $Audit | Select-Object -ExpandProperty AuditData | ConvertFrom-Json
    $ConvertAudit | Select-Object CreationTime,UserId,Operation,Workload,ObjectID,SiteUrl,SourceFileName,ClientIP,UserAgent | Export-Csv $OutputFile -NoTypeInformation -Append
    Write-Host $StartDate `t $Audit.Count
  }
}

```
