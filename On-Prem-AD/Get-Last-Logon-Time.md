# For a single user
```powershell
$Username = read-host -prompt "Who is the user?"
Get-ADUser -Identity $Username -Properties * | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}},@{Name='lastLogonTimestamp';Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}
```

# To Ask For List Of Users

```powershell
$users = @()
while ($input = read-host "Username?"){
    if($input -eq "" -or $input -eq $null) {break}
    $users += $input
}

foreach ($user in $users){
    Get-ADUser -Identity $User -Properties * | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}},@{Name='lastLogonTimestamp';Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}

}
```

### LastLogon vs LastLogonTimeStamp
- LastLogon means the timestamp for the user logged on happened on the domain controller it authenticated with. its generally more accurate compared to LastLogonTimestamp
- LastLogonTimeStamp is the least accurate and it only gets the information that was gathered via replication from other DC(s) that it authenticated with, generally its less accurate
