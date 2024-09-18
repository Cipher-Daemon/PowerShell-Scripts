# Title Case

```powershell
$Text = read-host "Text to Title Case"
$textInfo = (Get-Culture).TextInfo
$textInfo.totitlecase($Text)
```
