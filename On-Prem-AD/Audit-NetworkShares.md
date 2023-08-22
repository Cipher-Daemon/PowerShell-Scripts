# Audit Network Shares

## On All Servers On A Domain

```powershell
$ErrorActionPreference= 'silentlycontinue'
# Excluding Default and admin shares from search
$DefaultShares = @("ADMIN$","A$","B$","C$","D$","E$","F$","G$","H$","I$","J$","K$","L$","M$","N$","O$","P$","Q$","R$","S$","T$","U$","V$","W$","X$","Y$","Z$","IPC$","NETLOGON","SYSVOL")
$NoServers = @()
#$ComputerName = hostname
$NetShareReport = [System.Collections.Generic.List[Object]]::new()

$ActiveServers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} -Properties LastLogonDate |Where-Object {($_.LastLogonDate -gt (Get-Date).AddDays(-30))}
$ActiveServers = $ActiveServers.name

foreach ($server in $ActiveServers){
$NetworkShares = $Null
$SMBAccess = $Null

$NetworkShares = get-smbshare -CimSession $Server -ErrorVariable ServerError|?{$DefaultShares -notcontains $_.name}
if ($serverError){
        write-host -ForegroundColor Red "Server error, needs to run on $Server manually!"
        $NoServers += $Server
        }

$SMBAccess = foreach ($NetworkShare in $NetworkShares){get-smbshareAccess -CimSession $Server -name $NetworkShare.name}

foreach ($SMBShare in $SMBAccess){
    $ReportLine = [PSCustomObject] @{
    Computername = $Server
    ShareName = $SMBShare.name
    LocalPath = (get-smbshare -CimSession $Server -name $SMBShare.name).path
    AccountorGroup = $SMBShare.AccountName
    AccessGrant = $SMBShare.AccessControlType
    ShareRights = $SMBShare.AccessRight
    }
$NetShareReport.add($ReportLine)
}
}


$Servercount = $NoServers.count

if ($NoServers.count -eq 0){
    write-host -ForegroundColor Cyan "No Servers returned any errors!"
    Start-Sleep -Seconds 3
    }else{
    write-host -ForegroundColor Red "$Servercount Servers were not able to run this PS command remotely, need to run them on the servers themselves:"
    write-host ""
    write-host "$NoServers"
    write-host ""
    write-host "Press the enter key to continue..."
    read-host
    }

$NetShareReport|Out-GridView
```

## On A Standalone Server

```powershell
# Excluding Default and admin shares from search
$DefaultShares = @("ADMIN$","A$","B$","C$","D$","E$","F$","G$","H$","I$","J$","K$","L$","M$","N$","O$","P$","Q$","R$","S$","T$","U$","V$","W$","X$","Y$","Z$","IPC$","NETLOGON","SYSVOL")

$ComputerName = hostname
$NetShareReport = [System.Collections.Generic.List[Object]]::new()

#$NetworkShares = get-smbshare |?{$_.name -ne $DefaultShares}
$NetworkShares = get-smbshare |?{$DefaultShares -notcontains $_.name}


$SMBAccess = foreach ($NetworkShare in $NetworkShares){get-smbshareAccess -name $NetworkShare.name}

foreach ($SMBShare in $SMBAccess){
    $ReportLine = [PSCustomObject] @{
    Computername = $ComputerName
    ShareName = $SMBShare.name
    LocalPath = (get-smbshare -name $SMBShare.name).path
    AccountorGroup = $SMBShare.AccountName
    AccessGrant = $SMBShare.AccessControlType
    ShareRights = $SMBShare.AccessRight
    }
$NetShareReport.add($ReportLine)
}

$NetShareReport|Out-GridView
```
