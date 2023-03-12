# Get All members in All Distribution Lists

## The following script is still a work in progress but should still help you on generating a csv report(s) on all users in distribution lists.

```powershell
$EmailGroups = Get-MsolGroup -GroupType DistributionList
$CompanyName = read-host "What is the Company Name?"
$Path = c:\temp\$CompanyName\$GroupName-Members.csv
foreach ($Group in $EmailGroups){
    $GroupName = $Group.DisplayName
    Get-MsolGroupMember -GroupObjectId $Group.Objectid |select displayname, emailaddress, groupmembertype, islicensed|export-csv -append -path c:\temp\$CompanyName\$GroupName-Members.csv
    write-output "All users in $GroupName" >>c:\temp\$CompanyName\$GroupName-Members.csv
}
write-host -foregroundcolor cyan "All reports are saved in c:\temp\$CompanyName\ directory."
```
