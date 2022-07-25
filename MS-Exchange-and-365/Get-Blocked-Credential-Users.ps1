$SharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -Eq "SharedMailbox"}


Foreach ($user in $SharedMailboxes) {
get-MsolUser -UserPrincipalName $user.UserPrincipalName |select UserPrincipalName, blockcredential|where-object {$_.blockcredential -eq "False"}|Export-Csv C:\temp\$DefaultDomainName-BlockedCredential-Not-Enabled-For-SharedMailboxes.csv -Append
}
