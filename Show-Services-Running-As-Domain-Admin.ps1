$DomainAdminAnswer = read-host "Does this domain use a custom Domain Admin Account (ie. not 'Administrator')?"
if ($DomainAdminAnswer -eq "Yes" -or $DomainAdminAnswer -eq "Y"){
    $AdminName = read-host "What is the custom admin name? (DO NOT INCLUDE 'DOMAIN\'!)"
    }else{
        $AdminName = "Administrator"
}


$ServiceList = Get-WmiObject win32_service
$DomainRoot = (get-AdDomain).DistinguishedName
$DomainRootName = (get-AdDomain).Name
foreach ($Service in $ServiceList){
    $StatusRunAs = ($Service).startname
    $ServiceName = ($Service).Name
    $ServiceFriendlyName = ($Service).displayname
    if($StatusRunAs -eq $AdminName -or $StatusRunAs -eq "$DomainRoot\$AdminName" -or $StatusRunAs -eq "$DomainRootName\$AdminName"){
        write-host -foregroundcolor yellow "$ServiceName ($Servicefriendlyname) service is running as domain adminnistrator!"
    }else{

    }

}
