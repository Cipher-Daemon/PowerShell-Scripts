# For a single user
```powershell
$Username = read-host -prompt "Who is the user?"
Get-ADUser -Identity $Username -Properties * | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}},@{Name='lastLogonTimestamp';Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}
```

# TO Ask For List Of Users

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
