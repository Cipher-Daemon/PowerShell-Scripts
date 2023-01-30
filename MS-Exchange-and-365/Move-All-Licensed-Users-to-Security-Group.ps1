$Users = Get-MsolUser -All | where {$_.isLicensed -eq $true}

$GroupPrompt = read-host -prompt "Group Name?"

$DUOGroupGUID = ((Get-MsolGroup|?{$_.displayname -eq $GroupPrompt}).objectid).guid

foreach ($User in $users){
    Add-MsolGroupMember -GroupObjectId $DUOGroupGUID -GroupMemberType User -GroupMemberObjectId $user.ObjectId
}
