```powershell
$Rules = Get-NetFirewallRule
$Data = @()
foreach ($Rule in $Rules){
    $InstanceID = $($Rule.InstanceID)

    $Enabled = $($Rule.Enabled)
    $RuleName = $($Rule.DisplayName)
    $Action = $($Rule.Action)
    $ProfileLocation = $($Rule.profile)
    $Protocol = (Get-NetFirewallPortFilter|?{$_.InstanceID -eq $InstanceID}).protocol
    $Application = (Get-NetFirewallApplicationFilter|?{$_.InstanceID -eq $InstanceID}).AppPath
    $Direction = (Get-NetFirewallRule|?{$_.InstanceID -eq $InstanceID}).direction
    $LocalHost = (Get-NetFirewallAddressFilter|?{$_.InstanceID -eq $InstanceID}).localaddress
    $LocalPort = (Get-NetFirewallPortFilter|?{$_.InstanceID -eq $InstanceID}).localport
    $RemoteHost = (Get-NetFirewallAddressFilter|?{$_.InstanceID -eq $InstanceID}).remoteaddress
    $RemotePort = (Get-NetFirewallPortFilter|?{$_.InstanceID -eq $InstanceID}).remoteport
    $Row = ''|Select Enabled,Direction,RuleName,Action,Profile,Protocol,Application,LocalHost,LocalPort,RemoteHost,RemotePort
    $Row.Enabled = $Enabled 
    $Row.Direction = $Direction
    $Row.RuleName = $RuleName
    $Row.Action = $Action
    $Row.Profile = $ProfileLocation
    $Row.Protocol = $Protocol
    $Row.Application = $Application 
    $Row.LocalHost = $LocalHost
    $Row.LocalPort = $LocalPort
    $Row.RemoteHost = $RemoteHost
    $Row.RemotePort = $RemotePort

    $Data += $Row
    
}

$Data|out-gridview
```
