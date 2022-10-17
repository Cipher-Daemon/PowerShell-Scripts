$AllDomains = Get-AcceptedDomain

Foreach ($domain in $AllDomains){
    $SelKeySize1 = (get-DkimSigningConfig -identity $domain.domainname).Selector1KeySize
    $SelKeySize2 = (get-DkimSigningConfig -identity $domain.domainname).Selector2KeySize
    $RotationDate = (get-DkimSigningConfig -identity $domain.domainname).rotateondate
    $CurrentDate = Get-date
    if ($SelKeySize1 -eq 1024 -or $SelKeySize2 -eq 1024){
        if ($RotationDate.tostring("yyyyMMddHHMM") -le $CurrentDate.tostring("yyyyMMddHHMM")){
            Rotate-DkimSigningConfig -KeySize 2048 -identity $domain.domainname
            write-host -ForegroundColor cyan "$domain key rotated"
        }
        else{
            $Days = (New-TimeSpan -start ($CurrentDate).touniversaltime() -End $RotationDate.ToUniversalTime()).days
            $Hours = (New-TimeSpan -start ($CurrentDate).touniversaltime() -End $RotationDate.ToUniversalTime()).hours
            $Minutes = (New-TimeSpan -start ($CurrentDate).touniversaltime() -End $RotationDate.ToUniversalTime()).minutes
            write-host -ForegroundColor red "Key for $Domain not ready to be rotated yet! Please try again in $Days days $Hours hours and $Minutes Minutes."
        }
    }else {
        write-host -ForegroundColor magenta "$domain already has all keys rotated to 2048 bit, no changes made!"
    }
}
