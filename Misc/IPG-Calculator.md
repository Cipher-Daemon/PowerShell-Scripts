# IPG Calculator

```powershell
$AvailableBandwidth = read-host -prompt "Available Bandwidth (in Kbps)"
$DesiredBandwidth = read-host -prompt "Desired Bandwidth (in Kbps)"

$AvailableBandwidth = [int]$AvailableBandwidth
$DesiredBandwidth = [int]$DesiredBandwidth


$NewNumerator = $AvailableBandwidth - $DesiredBandwidth
$NewDenominator = $AvailableBandwidth * $DesiredBandwidth


$Fracton = $NewNumerator / $NewDenominator

$IPGValue = $Fracton * 512 * 1000

Write-host "IPG value to use is: $IPGValue"
```
