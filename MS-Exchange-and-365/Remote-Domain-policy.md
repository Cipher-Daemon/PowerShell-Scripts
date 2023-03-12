# To make a new remote domain policy

```powershell
New-RemoteDomain -DomainName *.contoso.com -Name Contoso
```

# To disable auto forwarding to the default

```powershell
Set-RemoteDomain Default -AutoForwardEnabled $false
```
