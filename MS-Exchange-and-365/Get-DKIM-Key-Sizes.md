# Get DKIM key sizes in 365

The following script below will display all your accepted domain(s) DKIM key length.

```powershell
$AllDomains = Get-AcceptedDomain


Foreach ($domain in $AllDomains){
    Get-DkimSigningConfig -identity $domain.domainname |select Domain, Selector1KeySize, Selector2KeySize
}
```
