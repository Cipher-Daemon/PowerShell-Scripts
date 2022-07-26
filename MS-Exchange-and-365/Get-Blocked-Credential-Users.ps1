#Must connect to tenant via Connect-ExchangeOnline for command to work
$SharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -Eq "SharedMailbox"}

#Must connect to tenant first via Connect-MsolService command for following command to work

$DefaultDomainName = Get-AcceptedDomain | Where-Object Default -EQ True

Foreach ($user in $SharedMailboxes) {
get-MsolUser -UserPrincipalName $user.UserPrincipalName |select UserPrincipalName, blockcredential|where-object {$_.blockcredential -eq "False"}|Export-Csv C:\temp\$DefaultDomainName-BlockedCredential-Not-Enabled-For-SharedMailboxes.csv -Append
}
