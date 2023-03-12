# Move all licensed users to a security group

The following below will get all the licensed users in your tenant and add them to a security group that you specify.

```powershell
$Users = Get-MsolUser -All | where {$_.isLicensed -eq $true}

$GroupPrompt = read-host -prompt "Group Name?"

$GroupGUID = ((Get-MsolGroup|?{$_.displayname -eq $GroupPrompt}).objectid).guid

foreach ($User in $users){
    Add-MsolGroupMember -GroupObjectId $GroupGUID -GroupMemberType User -GroupMemberObjectId $user.ObjectId
}
```
