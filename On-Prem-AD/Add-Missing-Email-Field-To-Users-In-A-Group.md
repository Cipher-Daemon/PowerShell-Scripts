## Have users in a group where email attribute is missing? Run this to fix that:

Uncomment in the foreach loop: one shows you whats missing, the other changes/inputs the email in the email attribute field.

```powershell
$NoEmail = Get-ADGroupMember -Identity <Group-Name>| Where-Object { $_.objectClass -eq 'user' } | Get-ADUser -Properties mail | Where-Object { $_.mail -eq $null }

foreach ($user in $Noemail){
    #get-aduser -Identity $user -Properties *|select name,mail
    #Set-ADUser -Identity $user.samaccountname -Replace @{mail=$user.userprincipalname}
    }
```
