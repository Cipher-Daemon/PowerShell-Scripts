# Blocked Credential Status Report

The following below will gather and dump all the status for users that are blocked and not blocked for shared mailbox users, all the reports will be saved in the C:\temp directory with the default domain name.

```powershell
$DefaultDomainName = Get-AcceptedDomain | Where-Object Default -EQ True
$SharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -Eq "SharedMailbox"}
new-item -path "C:\temp\" -name $DefaultDomainName -itemtype "Directory"
Foreach ($user in $SharedMailboxes){
    $CredentialStatus = (get-MsolUser -UserPrincipalName $user.UserPrincipalName).BlockCredential
    if($CredentialStatus -eq "True"){
        get-msoluser -UserPrincipalName $user.UserPrincipalName |select UserPrincipalName, blockcredential|export-csv C:\temp\$DefaultDomainName\$DefaultDomainName-Already-Blocked.csv -append
        write-host -ForegroundColor Cyan "$User is blocked!"
    }else{
        get-msoluser -UserPrincipalName $user.UserPrincipalName |select UserPrincipalName, blockcredential|export-csv C:\temp\$DefaultDomainName\$DefaultDomainName-Have-Not-Been-Blocked.csv -append
        write-host -ForegroundColor red "$User is NOT blocked!"
    }
}
write-host
write-host "All reports of users that are already blocked or not is saved in c:\temp\$DefaultDomainName Directory."
write-host
```
