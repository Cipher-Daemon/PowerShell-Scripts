$MaxNumber = read-host -Prompt "How many characters do you want?"
$ActualNumber = $MaxNumber - 1
$Password = New-Object -TypeName PSObject
$Password | Add-Member -MemberType ScriptProperty -Name "Password" -Value { ("!@#$%^&*0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz".tochararray() | sort {Get-Random})[0..$ActualNumber] -join '' }
$Password
