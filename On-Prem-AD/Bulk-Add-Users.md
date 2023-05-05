# Bulk Add Users

To bulk add users in AD with this script you need the following before you begin.
- The CSV File of all the users (Headers must include Firstname & Lastname)
- The OU path of where you want to dump the users to
- The Domain (for their UPN and mail field)

## The Script

Modify if needed

```powershell
Function RandomPassword{
$Password = New-Object -TypeName PSObject
$Password | Add-Member -MemberType ScriptProperty -Name "Password" -Value { ("!@#$%^&*234679ACEFGHJKMNPQRTUVWXYZ_abcdefghjkmnpqrtuvwxyz".tochararray() | sort {Get-Random})[0..23] -join '' }
$Password
}

$CSVFile = <CSV-File>
$OUPath = <OU Distinguished Name Path>
$Domain = <Domain Name>


import-csv -path $CSVFile |foreach-Object {
    $FirstName = $_.FirstName
    $LastName = $_.LastName
    $UserName = "$firstName.$lastName"
    $Password = (randompassword).password

    New-ADUser -Name "$firstName $lastName" -GivenName $firstName -Surname $lastName -SamAccountName $userName -UserPrincipalName "$userName@$domain" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -Path $OUPath -OtherAttributes @{'mail'="$userName@$domain"}
}
```
