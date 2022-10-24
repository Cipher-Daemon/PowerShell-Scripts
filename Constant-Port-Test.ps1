#Disclaimer: Should only be used on infrastructure you own. Purpose of this tool is to constantly check if port is open or troubleshoot said port until its open.

$machine = read-host -prompt "Hostname or IP address"
$Port = read-host -prompt "TCP Port"
$i = 0
$PortStatus = $null
while ($PortStatus -ne $true){
    $PortStatus = (Test-NetConnection -ComputerName $machine -Port $port).TcpTestSucceeded
    write-host "Attempt $i"
    $i++
    }
write-host -ForegroundColor Green -BackgroundColor Black "Port $Port on Host $machine is now open!"
