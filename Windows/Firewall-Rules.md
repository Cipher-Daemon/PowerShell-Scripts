# Slow Version
```powershell
#$Rules = Get-NetFirewallRule
$Data = @()
[int]$Rulecount = $($Rules.count)
[int]$ProcressCount = 1
foreach ($Rule in $Rules){
    $InstanceID = $($Rule.InstanceID)
    $ActualPercentage = ($ProcressCount/$Rulecount)*100
    Write-Progress -Activity "Generating Report" -Status "$ActualPercentage Percent Complete" -PercentComplete $ActualPercentage

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
    $ProcressCount++
    
}

$Data|out-gridview
```
# Fast Version

```powershell
$Rules = Get-NetFirewallRule
$RulesFWPort = Get-NetFirewallPortFilter
$RulesFWApp = Get-NetFirewallApplicationFilter
$RulesFWRule = Get-NetFirewallRule
$RulesFWAddress = Get-NetFirewallAddressFilter
$Data = @()
[int]$Rulecount = $($Rules.count)
[int]$ProcressCount = 1

# This logic checks if the InstanceID is a GUID String, reason is that it appears if a rule is created not part of the installation it assigns it as a GUID string.
function InstanceIDRegEx{
    $($Rule.InstanceID) -match '\{[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}\}'
}

foreach ($Rule in $Rules){
    $InstanceID = $($Rule.InstanceID)
    $ActualPercentage = ($ProcressCount/$Rulecount)*100
    Write-Progress -Activity "Generating Report" -Status "$ActualPercentage Percent Complete" -PercentComplete $ActualPercentage
    InstanceIDRegEx
    $CustomRule = $False

    if (InstanceIDRegEx){
        $CustomRule = $True
    }

    $Enabled = $($Rule.Enabled)
    $RuleName = $($Rule.DisplayName)
    $Action = $($Rule.Action)
    $ProfileLocation = $($Rule.profile)
    $Protocol = ($RulesFWPort|? InstanceID -eq $InstanceID).protocol
    $Application = ($RulesFWApp|? InstanceID -eq $InstanceID).AppPath
    $Direction = ($RulesFWRule|? InstanceID -eq $InstanceID).direction
    $LocalHost = ($RulesFWAddress|? InstanceID -eq $InstanceID).localaddress
    $LocalPort = ($RulesFWPort|? InstanceID -eq $InstanceID).localport
    $RemoteHost = ($RulesFWAddress|? InstanceID -eq $InstanceID).remoteaddress
    $RemotePort = ($RulesFWPort|? InstanceID -eq $InstanceID).remoteport
    $ICMPType = ($RulesFWPort|? InstanceID -eq $InstanceID).icmptype
    $Row = ''|Select CustomRule,Enabled,Direction,RuleName,Action,Profile,Protocol,ICMPType,Application,LocalHost,LocalPort,RemoteHost,RemotePort
    $Row.CustomRule = $CustomRule
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
    $Row.ICMPType = $ICMPType

    $Data += $Row
    $ProcressCount++
    
}

$Data|out-gridview
```

## ICMP Codes

- ICMPv4: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
- ICMPv6: https://www.iana.org/assignments/icmpv6-parameters/icmpv6-parameters.xhtml

## Protocol Numbers
- https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
