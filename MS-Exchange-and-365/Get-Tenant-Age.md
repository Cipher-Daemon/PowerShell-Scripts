# Get the exact time when a 365 tenant was created

## For Local Time

```powershell
(Get-OrganizationConfig).WhenCreated
```
## For UTC Time

```powershell
(Get-OrganizationConfig).WhenCreatedUTC
```
