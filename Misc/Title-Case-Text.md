# Title Case

```powershell
$Text = read-host "Text to Title Case"
$textInfo = (Get-Culture).TextInfo
$textInfo.totitlecase($Text)
```

## One Liner and copy to clipboard

```powershell
$Text = read-host "Text to Title Case";$textInfo = (Get-Culture).TextInfo;$textInfo.totitlecase($Text)|clip
```
