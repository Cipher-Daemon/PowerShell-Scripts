# Audit Successful Login And Their Types

This script will go through the security log and search the 4624 event id and puts it out in a readable grid, this can be useful for seeing if accounts still use NTLM if you decide to disable NTLM in your environment.

```powershell
$data = @()
$Events = Get-WinEvent -FilterHashtable @{LogName = 'Security';id = '4624'}


foreach ($Event in $Events){
    $info = $Null
    $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
    $TargetUserName = ($Event|select -ExpandProperty properties)[5]
    $LogonType = ($Event|select -ExpandProperty properties)[8]
    $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
    $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
    $WorkstationName = ($Event|select -ExpandProperty properties)[11]
    $IPAddress = ($Event|select -ExpandProperty properties)[18]
    $Row = ''|select SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
    $Row.SubjectUserName = $SubjectUserName.Value
    $Row.TargetUserName = $TargetUserName.value
    $Row.LogonType = $LogonType.value
    $Row.LogonProcessName = $LogonProcessName.value
    $Row.AuthenticationPackageName = $AuthenticationPackageName.value
    $Row.WorkstationName = $WorkstationName.value
    $Row.IPAddress = $IPAddress.value
    $Data += $Row
}

$Data|Out-Gridview
```

# For Auditing Domain Admins

```powershell
$data = @()
$Events = Get-WinEvent -FilterHashtable @{LogName = 'Security';id = '4624'}
$DomainAdmins = (get-adgroupmember -Identity 'Domain Admins').samaccountname

foreach ($Event in $Events){
    $info = $Null
    $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
    $TargetUserName = ($Event|select -ExpandProperty properties)[5]
    $LogonType = ($Event|select -ExpandProperty properties)[8]
    $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
    $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
    $WorkstationName = ($Event|select -ExpandProperty properties)[11]
    $IPAddress = ($Event|select -ExpandProperty properties)[18]
    $Row = ''|select SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
    $Row.SubjectUserName = $SubjectUserName.Value
    $Row.TargetUserName = $TargetUserName.value
    $Row.LogonType = $LogonType.value
    $Row.LogonProcessName = $LogonProcessName.value
    $Row.AuthenticationPackageName = $AuthenticationPackageName.value
    $Row.WorkstationName = $WorkstationName.value
    $Row.IPAddress = $IPAddress.value
    $Data += $Row
}


foreach ($admins in $DomainAdmins){
    $AdminEvents = $Data|?{$_.TargetUserName -contains $Admins -and $_.AuthenticationPackageName -eq "NTLM"}
    $AdminEventsCount = $AdminEvents.count
    if($AdminEventsCount -eq 0){
    write-host -foregroundcolor cyan "Account $Admins was using NTLM $AdminEventsCount Times!"
    }else{
        write-host -foregroundcolor yellow "Account $Admins was using NTLM $AdminEventsCount Times!"
    }
}
```
## Audit domain admins on all active servers

```powershell
$data = @()
$NoServers = @()
$DomainAdmins = (get-adgroupmember -Identity 'Domain Admins').samaccountname
$ErrorActionPreference= 'silentlycontinue'
$ActiveServers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} -Properties LastLogonDate |Where-Object {($_.LastLogonDate -gt (Get-Date).AddDays(-30))}
$ActiveServers = $ActiveServers.name

foreach ($Server in $ActiveServers){
    write-host -foregroundcolor cyan "Attempting on $Server"
    $Events = $Null
    $Events = Get-WinEvent -FilterHashtable @{LogName = 'Security';id = '4624'} -computername $Server -errorvariable ServerError
    if ($serverError){
        write-host -ForegroundColor Red "Server error, needs to run on $Server manually!"
        $NoServers += $Server
        }

foreach ($Event in $Events){
    $info = $Null
    $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
    $TargetUserName = ($Event|select -ExpandProperty properties)[5]
    $LogonType = ($Event|select -ExpandProperty properties)[8]
    $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
    $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
    $WorkstationName = ($Event|select -ExpandProperty properties)[11]
    $IPAddress = ($Event|select -ExpandProperty properties)[18]
    $Row = ''|select Server,SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
    $Row.Server = $Server
    $Row.SubjectUserName = $SubjectUserName.Value
    $Row.TargetUserName = $TargetUserName.value
    $Row.LogonType = $LogonType.value
    $Row.LogonProcessName = $LogonProcessName.value
    $Row.AuthenticationPackageName = $AuthenticationPackageName.value
    $Row.WorkstationName = $WorkstationName.value
    $Row.IPAddress = $IPAddress.value
    $Data += $Row
}

}

write-host -foregroundcolor green "=====LOG COLLECTION COMPLETE====="

foreach ($admins in $DomainAdmins){
    $AdminEvents = $Data|?{$_.TargetUserName -contains $Admins -and $_.AuthenticationPackageName -eq "NTLM"}
    $AdminEventsCount = $AdminEvents.count
    if($AdminEventsCount -eq 0){
    write-host -foregroundcolor cyan "Account $Admins was using NTLM $AdminEventsCount Times!"
    }else{
        write-host -foregroundcolor yellow "Account $Admins was using NTLM $AdminEventsCount Times!"
    }
}
```
## Filter only domain admins

Note: The variable $XPathConditions can only do up to 19 user accounts at a time so keep that in mind if your organization has more than that many domain admin accounts.
```powershell
$data = @()
$DomainAdmins = (Get-ADGroupMember -Recursive -Identity "Domain Admins").samaccountname

$XPathConditions = $DomainAdmins | ForEach-Object {
    "Data[@Name='TargetUserName']='{0}'" -f $_
}
$XPathConditionsString = $XPathConditions -join " or "

$FilterXPath = "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and (EventID=4624)] and EventData[Data[@Name='AuthenticationPackageName']='NTLM' and ($XPathConditionsString)]]"

$Events = Get-WinEvent -LogName Security -FilterXPath $FilterXPath



foreach ($Event in $Events){
    $info = $Null
    $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
    $TargetUserName = ($Event|select -ExpandProperty properties)[5]
    $LogonType = ($Event|select -ExpandProperty properties)[8]
    $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
    $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
    $WorkstationName = ($Event|select -ExpandProperty properties)[11]
    $IPAddress = ($Event|select -ExpandProperty properties)[18]
    $Row = ''|select SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
    $Row.SubjectUserName = $SubjectUserName.Value
    $Row.TargetUserName = $TargetUserName.value
    $Row.LogonType = $LogonType.value
    $Row.LogonProcessName = $LogonProcessName.value
    $Row.AuthenticationPackageName = $AuthenticationPackageName.value
    $Row.WorkstationName = $WorkstationName.value
    $Row.IPAddress = $IPAddress.value
    $Data += $Row
}


foreach ($admins in $DomainAdmins){
    $AdminEvents = $Data|?{$_.TargetUserName -contains $Admins}
    $AdminEventsCount = $AdminEvents.count
    if($AdminEventsCount -eq 0){
    write-host -foregroundcolor cyan "Account $Admins was using NTLM $AdminEventsCount Times!"
    }else{
        write-host -foregroundcolor yellow "Account $Admins was using NTLM $AdminEventsCount Times!"
    }
}
```

To get around the 19 admins limit

```powershell
cls
$ErrorActionPreference = "SilentlyContinue"
$Round = 1
$MinAdmin = 0
$MaxAdmin = 18
$data = @()
$DomainAdmins = (Get-ADGroupMember -Recursive -Identity "Domain Admins").samaccountname

$MaxRounds = [math]::Ceiling($DomainAdmins.count/19)

while ($Round -le $MaxRounds){

    $XPathConditions = $DomainAdmins[$MinAdmin..$MaxAdmin] | ForEach-Object {
        "Data[@Name='TargetUserName']='{0}'" -f $_
    }
    $XPathConditionsString = @()
    $XPathConditionsString = $XPathConditions -join " or "

    $FilterXPath = "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and (EventID=4624)] and EventData[Data[@Name='AuthenticationPackageName']='NTLM' and ($XPathConditionsString)]]"

    $Events = @()
    $Events = Get-WinEvent -LogName Security -FilterXPath $FilterXPath



    foreach ($Event in $Events){
        $info = $Null
        $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
        $TargetUserName = ($Event|select -ExpandProperty properties)[5]
        $LogonType = ($Event|select -ExpandProperty properties)[8]
        $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
        $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
        $WorkstationName = ($Event|select -ExpandProperty properties)[11]
        $IPAddress = ($Event|select -ExpandProperty properties)[18]
        $Row = ''|select SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
        $Row.SubjectUserName = $SubjectUserName.Value
        $Row.TargetUserName = $TargetUserName.value
        $Row.LogonType = $LogonType.value
        $Row.LogonProcessName = $LogonProcessName.value
        $Row.AuthenticationPackageName = $AuthenticationPackageName.value
        $Row.WorkstationName = $WorkstationName.value
        $Row.IPAddress = $IPAddress.value
        $Data += $Row
    }
    $Round = ++$Round
    $MinAdmin = $MinAdmin + 19
    $MaxAdmin = $MaxAdmin + 19
}





foreach ($admins in $DomainAdmins){
    $AdminEvents = $Data|?{$_.TargetUserName -contains $Admins}
    $AdminEventsCount = $AdminEvents.count
    if($AdminEventsCount -eq 0){
    write-host -foregroundcolor cyan "Account $Admins was using NTLM $AdminEventsCount Times!"
    }else{
        write-host -foregroundcolor yellow "Account $Admins was using NTLM $AdminEventsCount Times!"
    }
}
```
You could also add this to the bottom of the script to see what device is using which account:

```powershell
$Data|group TargetUsername,WorkstationName,IPAddress|Select name, count
```

## For specific time (Example 2 hours)

```powershell
$endTime = Get-Date
$startTime = $endTime.AddHours(-2)

# Format the start and end times in the required format for XPath
$startTimeFormatted = $startTime.ToString("yyyy-MM-ddTHH:mm:ss")
$endTimeFormatted = $endTime.ToString("yyyy-MM-ddTHH:mm:ss")

$data = @()
$DomainAdmins = (Get-ADGroupMember -Recursive -Identity "Domain Admins").samaccountname

$XPathConditions = $DomainAdmins | ForEach-Object {
    "Data[@Name='TargetUserName']='{0}'" -f $_
}
$XPathConditionsString = $XPathConditions -join " or "

$FilterXPath = "
*[System[Provider[@Name='Microsoft-Windows-Security-Auditing']
 and (EventID=4624)] 
 and EventData[Data[@Name='AuthenticationPackageName']='NTLM' 
 and ($XPathConditionsString)]
 and System[TimeCreated[@SystemTime >= '$startTimeFormatted' and @SystemTime <= '$endTimeFormatted']]
 ]"


$Events = Get-WinEvent -LogName Security -FilterXPath $FilterXPath



foreach ($Event in $Events){
    $info = $Null
    $SubjectUserName = ($Event|select -ExpandProperty properties)[1]
    $TargetUserName = ($Event|select -ExpandProperty properties)[5]
    $LogonType = ($Event|select -ExpandProperty properties)[8]
    $LogonProcessName = ($Event|select -ExpandProperty properties)[9]
    $AuthenticationPackageName = ($Event|select -ExpandProperty properties)[10]
    $WorkstationName = ($Event|select -ExpandProperty properties)[11]
    $IPAddress = ($Event|select -ExpandProperty properties)[18]
    $Row = ''|select SubjectUserName,TargetUserName,LogonType,LogonProcessName,AuthenticationPackageName,WorkstationName,IPAddress
    $Row.SubjectUserName = $SubjectUserName.Value
    $Row.TargetUserName = $TargetUserName.value
    $Row.LogonType = $LogonType.value
    $Row.LogonProcessName = $LogonProcessName.value
    $Row.AuthenticationPackageName = $AuthenticationPackageName.value
    $Row.WorkstationName = $WorkstationName.value
    $Row.IPAddress = $IPAddress.value
    $Data += $Row
}


foreach ($admins in $DomainAdmins){
    $AdminEvents = $Data|?{$_.TargetUserName -contains $Admins}
    $AdminEventsCount = $AdminEvents.count
    if($AdminEventsCount -eq 0){
    write-host -foregroundcolor cyan "Account $Admins was using NTLM $AdminEventsCount Times!"
    }else{
        write-host -foregroundcolor yellow "Account $Admins was using NTLM $AdminEventsCount Times!"
    }
}
```
