```powershell
#$Rules = Get-NetFirewallRule
$Data = @()
foreach ($Rule in $Rules){
    $InstanceID = $($Rule.InstanceID)

    $Enabled = $($Rule.Enabled)
    $RuleName = $($Rule.DisplayName)
    $Action = $($Rule.Action)
    $Profile = $($Rule.profile)
    $Protocol = (Get-NetFirewallPortFilter|?{$_.InstanceID -eq $InstanceID}).protocol
    $Application = (Get-NetFirewallApplicationFilter|?{$_.InstanceID -eq $InstanceID}).AppPath
    #$Direction = 
    $LocalHost = (Get-NetFirewallAddressFilter|?{$_.InstanceID -eq $InstanceID}).localaddress
    $LocalPort = (Get-NetFirewallPortFilter|?{$_.InstanceID -eq $InstanceID}).localport
    $RemoteHost = (Get-NetFirewallAddressFilter|?{$_.InstanceID -eq $InstanceID}).remoteaddress
    $RemotePort = (Get-NetFirewallPortFilter|?{$_.InstanceID -eq $InstanceID}).remoteport
    
    
}
```
