# Quick list with new lines

```powershell
$AllList = @"

"@ -split "`r?`n"
```


```powershell

$AllList = (Read-Host "List of items") -split "`r?`n" |ForEach-Object { $_.Trim() } |Where-Object { $_ }|sort

```
