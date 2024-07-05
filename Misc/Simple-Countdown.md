# Simple Countdown

```powershell
[int32]$y = 300
$y2 = ($y/60)

while ($y -ge 0){
    $y2 = ($y/60)
    Get-Date -Minute([System.Math]::Truncate($y2)) -Second($y % 60) -UFormat %M:%S
    $y -= 1
    Start-Sleep -Seconds 1
    }
```
