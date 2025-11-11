# Conditional Access

```powershell
Connect-MgGraph -Scopes "User.Read.All", "Policy.ReadWrite.ConditionalAccess", "RoleManagement.Read.Directory"

$altALTERNATIVEAdminAccount = $Null
$altALTERNATIVEAdminAccount = (Get-MgUser|?{$_.DisplayName -eq "ALTERNATIVEAlt"}).id
$GlobalAdminGUID = "62e90394-69f5-4237-9190-012177145e10"
$CACreationResult = $Null

function CreateConditionalAccessPolicy{
write-host -ForegroundColor cyan "Creating CA Policy"

        $params = @{
	        displayName = "ALTERNATIVE-Signin-Frequency-And-Non-Persistent-For-Admins"
	        state = "disabled"
	        conditions = @{

        clientAppTypes = @(
        "all"
        )
        applications = @{
        includeApplications = @(
        "All"
        )
        excludeApplications = @(

        )
        includeUserActions = @(
        )
        }
        users = @{
        includeUsers = @(

        )
        excludeUsers = @(
        $altALTERNATIVEAdminAccount
        )
        includeGroups = @(
        )
        excludeGroups = @(
        )
        includeRoles = @(
        "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3" #Application Administrator
        "c4e39bd9-1100-46d3-8c65-fb160da0071f" #Authentication Administrator
        "b0f54661-2d74-4c50-afa3-1ec803f12efe" #Billing Administrator
        "158c047a-c907-4556-b7ef-446551a6b5f7" #Cloud Application Administrator
        "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9" #Conditional Access Administrator
        "29232cdf-9323-42fd-ade2-1d097af3e4de" #Exchange Administrator
        "62e90394-69f5-4237-9190-012177145e10" #Global Administrator
        "f2ef992c-3afb-46b9-b7cf-a126ee74c451" #Global Reader
        "729827e3-9c14-49f7-bb1b-9608f156bbb8" #Helpdesk Administrator
        "966707d0-3269-4727-9be2-8c3a10f19b9d" #Password Administrator
        "7be44c8a-adaf-4e2a-84d6-ab2649e08a13" #Privileged Authentication Administrator
        "e8611ab8-c189-46e8-94e1-60213ab1f814" #Privileged Role Administrator
        "194ae4cb-b126-40b2-bd5b-6091b380977d" #Security Administrator
        "f28a1f50-f6e7-4571-818b-6a12f2af6b6c" #Sharepoint Administrator
        "fe930be7-5e62-47db-91af-98c3a49a38b1" #User Administrator
        )
        excludeRoles = @(
        )
        }
        <#
        platforms = @{
        includePlatforms = @(
        )
        excludePlatforms = @(

        )
        }
        locations = @{
        includeLocations = @(
        "All"
        )
        excludeLocations = @(

        )
        }
        #>
        }
        grantControls = @{
        operator = "OR"
        builtInControls = @(
        "mfa"
        )
        customAuthenticationFactors = @(
        )
        termsOfUse = @(

        )
        }
        sessionControls = @{
        #applicationEnforcedRestrictions = $null
        #persistentBrowser = $null
        signInFrequency = @{
        value = 4
        type = "hours"
        authenticationType = "primaryAndSecondaryAuthentication"
        frequencyInterval = "timeBased"
        isEnabled = $true
        }
        persistentBrowser = @{
        mode = "never"
        isEnabled = $true
        }
        }
        }

        New-MgIdentityConditionalAccessPolicy -BodyParameter $params 



}

function CheckIfAltAccountIsGA {
    $Result = $Null
    $Result = Get-MgRoleManagementDirectoryRoleAssignment -Filter "principalId eq '$($altALTERNATIVEAdminAccount)' and roleDefinitionId eq '$($GlobalAdminGUID)'"

    if (-not $Result){
        write-host -ForegroundColor Red "altALTERNATIVE Doesnt appear to be a Global Admin!"
        }else{
            CreateConditionalAccessPolicy
        }
}

if (-not $altALTERNATIVEAdminAccount){
write-host -ForegroundColor red "ALTERNATIVEAlt account doesnt exist!"
}else{
    #CreateConditionalAccessPolicy
    CheckIfAltAccountIsGA
}



#Disconnect-MgGraph
```
