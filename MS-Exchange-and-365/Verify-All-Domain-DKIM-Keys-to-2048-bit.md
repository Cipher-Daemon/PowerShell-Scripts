# Verify All Domains Are Rotated To 2048 Bit DKIM Keys

The following below will only show the key size status of all accepted domains in your tenant and will tell you if they are rotated to 2048 bit.

```powershell
$AllDomains = Get-AcceptedDomain

Foreach ($domain in $AllDomains){
    $SelKeySize1 = (get-DkimSigningConfig -identity $domain.domainname).Selector1KeySize
    $SelKeySize2 = (get-DkimSigningConfig -identity $domain.domainname).Selector2KeySize
    if ($SelKeySize1 -eq 1024 -or $SelKeySize2 -eq 1024){
        Get-DkimSigningConfig -identity $domain.domainname |select Domain, Selector1KeySize, Selector2KeySize
    }else {
        write-host -ForegroundColor green "$domain has all keys rotated to 2048 bit!"
    }
}
```
