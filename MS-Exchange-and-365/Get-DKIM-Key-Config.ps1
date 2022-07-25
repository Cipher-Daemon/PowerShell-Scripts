#change identity string for commands to work


Get-DkimSigningConfig -identity [Tenant-Domain]|select Domain, Selector1KeySize, Selector2KeySize



Get-DkimSigningConfig -identity [tenant-onmicrosoft-Domain]|select Domain, Selector1KeySize, Selector2KeySize
