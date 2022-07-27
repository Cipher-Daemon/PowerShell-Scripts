#Must first connect with Connect-ExchangeOnline for this to work

$AllDomains = Get-AcceptedDomain


Foreach ($domain in $AllDomains){
    Get-DkimSigningConfig -identity $domain.domainname |select Domain, Selector1KeySize, Selector2KeySize
}
