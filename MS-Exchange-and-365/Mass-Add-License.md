# Mass Add License In Office/Microsoft 365

## Prerequisite
- For this command to work you must have the MSOnline module installed.
- You must also connect your 365 tenant for this to work with command:
```powershell
Connect-MsolService
```



## Getting the License Name

To get the SKU/License name for your powershell script run the following command to get all the license in your tenant:
```powershell
Get-MsolAccountSku
```

The format is usually [TenantName]:[LicenseName]

For example if your tenant is MyDomain.onmicrosoft.com and the license you want to assign is Azure Active Directory Premium P1 it'll show this:

```
AccountSkuId                              ActiveUnits WarningUnits ConsumedUnits
------------                              ----------- ------------ -------------
MyDomain:AAD_PREMIUM                      [Total #]                [Used #]
```

## Mass Assign Users

For this example we'll assume that the users are already licensed, if you want to assign to everyone (with or without a license) you can remove the pipe in the LicensedUsers variable:

```powershell
$LicensedUsers = Get-MsolUser|?{$_.IsLicensed -eq $True}

foreach ($User in $LicensedUsers){
    Set-MsolUserLicense -UserPrincipalName $User.UserPrincipalName -AddLicenses "MyDomain:AAD_PREMIUM"
}
```

Alternatively this will work the exact same way from the previous example by selecting the license from the Get-MsolAccountSku array (your results may vary on the position within the array):

```powershell
$LicensedUsers = Get-MsolUser|?{$_.IsLicensed -eq $True}
$License = (Get-MsolAccountSku).AccountSkuId[0]
foreach ($User in $LicensedUsers){
    Set-MsolUserLicense -UserPrincipalName $User.UserPrincipalName -AddLicenses $License
}
```
Depending on how many users you have it can take time to assign users that specific license.

Also note that other licenses will not be removed since all we are doing is adding a license(s).
