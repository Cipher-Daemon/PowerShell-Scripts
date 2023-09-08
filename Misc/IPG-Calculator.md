# IPG Calculator <WIP>

```powershell
$AvailableBandwidth = read-host -prompt "Available Bandwidth (in Kbps)"
$DesiredBandwidth = read-host -prompt "Desired Bandwidth (in Kbps)"

$NewNumerator = $AvailableBandwidth - $DesiredBandwidth
$NewDenominator = $AvailableBandwidth * $DesiredBandwidth

$Fracton = $NewNumerator / $NewDenominator

$IPGValue = $Fracton * 512 * 1000

Write-host "IPG value to use is: $IPGValue"
```
