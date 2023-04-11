$Username = read-host -prompt "Who is the user?"
Get-ADUser -Identity $Username -Properties * | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}},@{Name='lastLogonTimestamp';Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}
