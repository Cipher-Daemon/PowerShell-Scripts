# Quick way

```powershell
#Run the command below to get the adapter ID
[int]$InterfaceIndex = Get-NetIPInterface|Where-Object {$_.AddressFamily -eq "IPv4" -and $_.Dhcp -eq "Enabled"}|select ifindex, interfacealias|Sort-Object -Property ifindex|select -ExpandProperty ifindex

$NETIFINDEX = $InterfaceIndex

$DomainName = read-host "Domain Name?"
$DomainNetBiosName = read-host "NetBios Domain Name?"

$NETALIAS = (Get-NetIPInterface|Where-Object {$_.ifindex -eq $NETIFINDEX -and $_.AddressFamily -eq "IPv4"}).InterfaceAlias


$IPADDR = "10.69.69.1"
$SUBNET = "24"
$DEFGATEWAY = "10.69.69.254"
$DNSSERVER = "127.0.0.1"

New-NetIPAddress -InterfaceAlias $NETALIAS -IPAddress $IPADDR -AddressFamily IPv4 -DefaultGateway $DEFGATEWAY -PrefixLength $SUBNET
Set-DnsClientServerAddress -InterfaceAlias $NETALIAS -ServerAddresses $DNSSERVER





$Secure_String_Pwd = ConvertTo-SecureString "Password1234$$" -AsPlainText -Force


install-windowsfeature DHCP -IncludeManagementTools




Add-DhcpServerv4Scope -Name "Lab Network" -StartRange 10.69.69.10 -EndRange 10.69.69.100 -SubnetMask 255.255.255.0




install-windowsfeature DNS -IncludeManagementTools
Set-DhcpServerv4OptionValue -DnsServer 10.69.69.1 -DnsDomain $DomainName -scopeid 10.69.69.0


Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $DomainName -DomainNetBiosName $DomainNetBiosName -InstallDns:$true -NoRebootOnCompletion:$true -SafeModeAdministratorPassword $Secure_String_Pwd -force
```
