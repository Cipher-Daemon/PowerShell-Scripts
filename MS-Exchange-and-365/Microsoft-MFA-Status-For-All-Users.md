# Microsoft MFA Status For All Users

## Prerequisite

You must have the MSOLService powershell Module installed

## Script To Get The List Of Users MFA Status

```powershell
$AllNonGuestUsers = Get-MsolUser -All | Where-Object { $_.UserType -ne "Guest" }
$Report = [System.Collections.Generic.List[Object]]::new()
foreach ($user in $AllNonGuestUsers){
    $MFADefaultMethod = ($User.StrongAuthenticationMethods | Where-Object { $_.IsDefault -eq "True" }).MethodType

    If ($User.StrongAuthenticationRequirements) {
        $MFAState = $User.StrongAuthenticationRequirements.State
    }
    Else {
        $MFAState = 'Disabled'
    }

    If ($MFADefaultMethod) {
        Switch ($MFADefaultMethod) {
            "OneWaySMS" { $MFADefaultMethod = "Text code authentication phone" }
            "TwoWayVoiceMobile" { $MFADefaultMethod = "Call authentication phone" }
            "TwoWayVoiceOffice" { $MFADefaultMethod = "Call office phone" }
            "PhoneAppOTP" { $MFADefaultMethod = "Authenticator app or hardware token" }
            "PhoneAppNotification" { $MFADefaultMethod = "Microsoft authenticator app" }
        }
    }
    Else {
        $MFADefaultMethod = "Not enabled"
    }

    $ReportLine = [PSCustomObject] @{
        UserPrincipalName = $User.UserPrincipalName
        DisplayName       = $User.DisplayName
        MFAState          = $MFAState
        MFADefaultMethod  = $MFADefaultMethod
    }
                 
    $Report.Add($ReportLine)
}
```

### Use The Out-GridView To See The Results
```powershell
$report|Sort UserPrincipalName|Out-GridView
```

### To Save A CSV Report
```powershell
$Report | Sort UserPrincipalName | Export-CSV -Encoding UTF8 -NoTypeInformation "c:\temp\MFAUsers.csv"
```
