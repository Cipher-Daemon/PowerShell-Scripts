$AllDomains = Get-AcceptedDomain

Foreach ($domain in $AllDomains){
    $SelKeySize1 = (get-DkimSigningConfig -identity $domain.domainname).Selector1KeySize
    $SelKeySize2 = (get-DkimSigningConfig -identity $domain.domainname).Selector2KeySize
    if ($SelKeySize1 -eq 1024 -or $SelKeySize2 -eq 1024){
        Rotate-DkimSigningConfig -KeySize 2048 -identity $domain.domainname
        write-host -ForegroundColor cyan "$domain key rotated"

    }else {
        write-host -ForegroundColor magenta "$domain already has all keys rotated to 2048 bit, no changes made!"
    }
}

#If this is the first time running this script, wait 72 hours or more to rotate the second key for full rotation to complete.
