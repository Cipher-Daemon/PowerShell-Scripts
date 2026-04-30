How to annoy the living nerves of your coworkers, replace/add the letters to your coworkers name.

```powershell
start-sleep -Seconds 5
Add-Type -AssemblyName System.Windows.Forms
[int]$MilliSeconds = 100
for ($i=0;$i -le 8;$i++){

[System.Windows.Forms.SendKeys]::SendWait('@')
Start-Sleep -Milliseconds $MilliSeconds
[System.Windows.Forms.SendKeys]::SendWait('r')
Start-Sleep -Milliseconds $MilliSeconds
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds $MilliSeconds
write-host -ForegroundColor Red $i
}
```
## Other functions

Control V (Paste) - `[System.Windows.Forms.SendKeys]::SendWait('^v')`
