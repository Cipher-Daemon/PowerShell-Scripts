# Force Password Change at next logon

To force the user to change their password w/o impacting their current password use the following command:

```powershell
Set-MsolUserPassword -UserPrincipalName <USER-UPN> -ForceChangePassword:$True -ForceChangePasswordOnly:$True
```

the ForceChangePassword generates the password but the ForceChangePasswordOnly doesnt change the password at all.
