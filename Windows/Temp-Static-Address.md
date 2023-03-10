# Temporary Static IP Address

## How this works

Say you have a computer where it (Somehow) lives on 2 different subnets at the same time and you want to configure it to see if it can talk on another subnet? If you are in front of the machine thats no big deal, but what if you are a remote technician and there is no one to help you once you do so?

This script helps by setting a temporary static IP address for 30 seconds. no need to worry or say "well what if..." this script should help you, and others, save time.

(Use Powershell ISE or save the script so that it'll process the script rather on waiting on human input to press enter if you rather pate it all in a powershell window)

```powershell
Get-NetIPInterface|Where-Object {$_.AddressFamily -eq "IPv4" -and $_.Dhcp -eq "Enabled"}|select ifindex, interfacealias|Sort-Object -Property ifindex

$NETIFINDEX = read-host "Which interface you want to manipulate?"

$NETALIAS = (Get-NetIPInterface|Where-Object {$_.ifindex -eq $NETIFINDEX -and $_.AddressFamily -eq "IPv4"}).InterfaceAlias


$IPADDR = read-host "IP address?"
$SUBNET = read-host "Subnet mask (in CIDR notation)?"
$DEFGATEWAY = read-host "Default Gateway?"
$DNSSERVER = read-host "DNS Server?"

New-NetIPAddress -InterfaceAlias $NETALIAS -IPAddress $IPADDR -AddressFamily IPv4 -DefaultGateway $DEFGATEWAY -PrefixLength $SUBNET
Set-DnsClientServerAddress -InterfaceAlias $NETALIAS -ServerAddresses $DNSSERVER


Start-Sleep -Seconds 30

Set-NetIPInterface -InterfaceIndex $NETIFINDEX -Dhcp Enabled
```

### Note: For some reason the first line will not display anything if running the whole script in ISE or running from a .ps1 file, you can copy the first line and reference it on the rest of the script.
