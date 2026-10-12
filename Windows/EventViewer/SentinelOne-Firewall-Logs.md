# S1 Firewall Logs

```poowershell
cls

[int]$Minutes = read-host "How many Minutes do you want to go back?"

$Milliseconds = $Minutes * 60 * 1000

$S1FirewallEvent = get-winevent -LogName "SentinelOne/Firewall" -FilterXPath "*[System[TimeCreated[timediff(@SystemTime) <= $Milliseconds]]]" -ErrorAction SilentlyContinue


function GetS1Logs {

    $Data = [System.Collections.Generic.List[Object]]::new()

    foreach ($Event in $S1FirewallEvent){

        $ProtocolValue = $Null

        Switch ((($Event|select -ExpandProperty properties)[12]).value){
            #If more needs to be added, refer to the protocol list at https://www.iana.org/assignments/protocol-numbers
            6 {$ProtocolValue = 'TCP'}
            17 {$ProtocolValue = 'UDP'}
            Default {$ProtocolValue = 'Unknown'}


        }

        $ReportLine = [PSCustomObject] @{
            Time = ($Event.TimeCreated).ToString("yyyy/MM/dd HH:MM:ss")
            Protocol = $ProtocolValue
            Direction = (($Event|select -ExpandProperty properties)[4]).value
            RemoteAddress = (($Event|select -ExpandProperty properties)[0]).value
            RemotePort = (($Event|select -ExpandProperty properties)[1]).value
            FQDN = (($Event|select -ExpandProperty properties)[7]).value
            LocalAddress = (($Event|select -ExpandProperty properties)[10]).value
            LocalPort = (($Event|select -ExpandProperty properties)[11]).value
        
            }
        $Data.Add($ReportLine)
    }


    $data|ft

}

if ($S1FirewallEvent.Count -eq 0){
    write-host -ForegroundColor Yellow "No events were found in the last $Minutes Minute(s). Expand the time range or verify that S1 firewall logs exist!"
    } else {GetS1Logs}

```
