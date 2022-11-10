$File = read-host "Full path to file"
<#
Optional: to remove all spaces.
(get-content $File).trim()
#>
(Get-Content $File) -join ","|clip
