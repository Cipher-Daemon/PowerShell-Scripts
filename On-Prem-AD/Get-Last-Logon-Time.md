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
#### LastLogon 
- Data is not replicated between domain controllers, meaning the data is recorded against the server itself when the user logs on
- Generally more accurate

#### LastLogonTimeStamp 
- Logon times are replicated to/from other domain controllers
- Generally less accurate
