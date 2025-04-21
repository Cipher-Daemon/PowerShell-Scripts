```powershell

$MsGraphVersion = "v1.0"

$MsGraphHost = "graph.microsoft.com"

$ClientID = "<CLIENT ID GUID>"

$TenantId = "<TENANT ID GUID>"

$ClientSecret = "<CLIENT SECRET>"

$Body = @{client_id=$ClientID;client_secret=$ClientSecret;grant_type="client_credentials";scope="https://$MSGraphHost/.default";}

$OAuthReq = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Body $Body

$AccessToken = $OAuthReq.access_token

$Hash = "<THE HASH OF THE MACHINE FOR AUTOPILOT>"
$PostData = @{'hardwareIdentifier' = "$hash"} | ConvertTo-Json


$Post =  Invoke-RestMethod -Method POST -Uri "https://$MSGraphHost/$MsGraphVersion/devicemanagement/importedWindowsAutopilotDeviceIdentities" -Headers @{Authorization = "Bearer $AccessToken"; 'Content-Type' = 'application/json'} -Body $PostData

# To check the status
Invoke-RestMethod -Method Get -Uri "https://$MsGraphHost/$MsGraphVersion/Devicemanagement/importedwindowsautopilotdeviceidentities/$($Post.ID)" -Headers @{Authorization = "Bearer $AccessToken"} | Select-Object -ExpandProperty State
```
