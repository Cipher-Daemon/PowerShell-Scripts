# Download Files The Quick Way

```powershell
$URL = Read-host "URL"
$Path = read-host "Path to save"
(New-Object System.Net.WebClient).DownloadFile ($URL, $Path)
```
