# Office 365 SafeLinks URL Decode

```powershell
$SafeLinksURL = read-host -prompt "Safelinks URL?"

$URLParts = $SafeLinksURL.split("?")[1]

$TargetURL = $URLParts.split("&")

$NewURL = $TargetURL[0].split("=")

$FinalURL = [System.Net.WebUtility]::URLDecode($NewURL)

$FinalURL.Split(" ")[1]
```
