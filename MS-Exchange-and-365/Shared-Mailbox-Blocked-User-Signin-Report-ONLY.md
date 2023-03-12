# Show Shared Mailboxes Blocked Credential Status

The following below will show the blocked credential status for all shared mailboxes.

```powershell
$SharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -Eq "SharedMailbox"}
Foreach ($user in $SharedMailboxes){
    $CredentialStatus = (get-MsolUser -UserPrincipalName $user.UserPrincipalName).BlockCredential
    if($CredentialStatus -eq "True"){
        write-host -ForegroundColor Cyan "$User is blocked!"
    }else{
        write-host -ForegroundColor red "$User is NOT blocked!"
    }
}
```
