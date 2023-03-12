#  Want something to show in a background? Here you can use this script to do so.

```powershell
while ($true){
$randomMS = get-random -Maximum 2500
$a = get-random -Minimum 1 -maximum 255
$b = get-random -maximum 256
$c = get-random -maximum 256
$d = get-random -maximum 256
$e = "$a.$b.$c.$d"
write-host -backgroundcolor black -foregroundcolor red "Invalid Connection From $e"
Start-Sleep -Milliseconds $randomMS
}
```
