$Username = read-host -prompt "Who is the user?"
Get-ADUser -Identity $Username -Properties LastLogon | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}}
