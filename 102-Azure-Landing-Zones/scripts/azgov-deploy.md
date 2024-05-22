# Azure Governance Visualizer Accelerator Automation Scrtip
### Source https://github.com/Azure/Azure-Governance-Visualizer-Accelerator

```powershell

##--------------------------------------------------##

# Required PowerShell Modules:
- https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.4.0
- Install-Module -Name Az 
- Specifically 'Az.Accounts', 'Az.Resources' & 'Az.ResourceGraph' if you need to limit what is installed

##--------------------------------------------------##

# Required GitHub CLI:
- winget install --id GitHub.cli
# Restart the PowerShell session:
- exit

##--------------------------------------------------##

# Check for pre-reqs
#winget list Microsoft.PowerShell
#Requires -Modules @{ ModuleName="Az.Accounts"; ModuleVersion="2.5.2" }
#Requires -Modules @{ ModuleName="Az.Resources"; ModuleVersion="4.3.0" }
#Requires -Modules @{ ModuleName="Az.ResourceGraph"; ModuleVersion="0.7.7" }
#Requires -Modules @{ ModuleName="Az.Security"; ModuleVersion="1.3.0" }
#winget list GitHub.cli

##--------------------------------------------------##

# Define environment variables
$MicrosoftGraphAppId = "00000003-0000-0000-c000-000000000000"
$AzGovVizAppName = "<App registration name that will be used to run AzGovViz>"
$managementGroupId = "<managementGroupId>" # The Management Group ID where the AzGovViz service principal will have access to
$tenantId = "<Microsoft Entra tenant ID>" # The Microsoft Entra tenant ID
$subscriptionId = "<Subscription Id>" # Subscription ID where the AzGovViz Web App will be created

# Define variables for the App Service Resource group
# Modify the following variables with the appropriate values for your environment including tags.
$resourceGroupName = "Name of the resource group where the Azure Web App will be created>"
$location = "<Azure Region for the Azure Web App>"
$tags = @{environment= "alz"; costcenter= "shared"; workload="azgov"; owner="jonathan"}

# Define variables for the Azure Web App
$webAppName = "<Azure Web App name to publish AzGovViz>" # 2-60 Alphanumeric, hyphens and Unicode characters. Can't start or end with hyphen. A web site must have a globally unique name.
$WebApplicationAppName = "<App registration name that will be used to add Microsoft Entra ID-based authentication to the web app>"

# Define GitHub variables
$directoryToCloneAccelerator = "<Local directory to clone the Accelerator's repository>"
$GitHubOrg = "<GitHub organization to use>"
$GitHubRepository = "Azure-Governance-Visualizer"

##--------------------------------------------------##

# Use PowerShell to create the service principal
$module = Get-Module -Name "AzAPICall" -ListAvailable
if ($module) {
  Update-Module -Name "AzAPICall" -Force
} else {
  Install-Module -Name AzAPICall
}
Connect-AzAccount

##--------------------------------------------------##

# Install AzAPICall and connect to Azure
$parameters4AzAPICallModule = @{
    #SubscriptionId4AzContext = $null #specify Subscription Id
    #DebugAzAPICall = $true
    #WriteMethod = 'Output' #Debug, Error, Host, Information, Output, Progress, Verbose, Warning (default: host)
    #DebugWriteMethod = 'Warning' #Debug, Error, Host, Information, Output, Progress, Verbose, Warning (default: host)
    #SkipAzContextSubscriptionValidation = $true #Use if the account doesn´t have any permissions on Management Groups,  Subscriptions, Resource Groups or Resources
  }
  
  $azAPICallConf = initAzAPICall @parameters4AzAPICallModule

##--------------------------------------------------##

# Get Microsoft Graph permissions role IDs and the create app registration
$apiEndPoint = $azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph
$apiEndPointVersion = '/v1.0'
$api = '/servicePrincipals'
$optionalQueryParameters = "?`$filter=(displayName eq 'Microsoft Graph')&$count=true&"

$uri = $apiEndPoint + $apiEndPointVersion + $api + $optionalQueryParameters

$azAPICallPayload = @{
    uri= $uri
    method= 'GET'
    currentTask= "'$($azAPICallConf['azAPIEndpoints'].($apiEndPoint.split('/')[2])) API: Get - Groups'"
    consistencyLevel= 'eventual'
    noPaging= $true
    AzAPICallConfiguration = $azAPICallConf
}

$graphApp = AzAPICall @azAPICallPayload
$appRole = $graphApp.appRoles | Where-Object { $_.value -eq 'Application.Read.All' } | Select-Object -ExpandProperty id
$userRole = $graphApp.appRoles | Where-Object { $_.value -eq 'User.Read.All' } | Select-Object -ExpandProperty id
$groupRole = $graphApp.appRoles | Where-Object { $_.value -eq 'Group.Read.All' } | Select-Object -ExpandProperty id
$pimRole = $graphApp.appRoles | Where-Object { $_.value -eq 'PrivilegedAccess.Read.AzureResources' } | Select-Object  -ExpandProperty id

$body = @"
{
  "DisplayName":"$AzGovVizAppName",
  "requiredResourceAccess" : [
    {
      "resourceAppId" : "$MicrosoftGraphAppId",
      "resourceAccess": [
        {
          "id": "$appRole",
          "type": "Role"
        },
        {
          "id": "$userRole",
          "type": "Role"
        },
        {
          "id": "$groupRole",
          "type": "Role"
        },
        {
          "id": "$pimRole",
          "type": "Role"
        }
      ]
    }
  ]
}
"@

$AzGovVizAppObjectId = (AzAPICall -method POST -body $body -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel 'eventual').id

do {
  Write-Host "Waiting for the AzGovViz service principal to get created..."
  Start-Sleep -seconds 20
  $AzGovVizAppId = (AzAPICall -method GET -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications/$AzGovVizAppObjectId" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel  'eventual' -skipOnErrorCode 404).appId
} until ($null -ne $AzGovVizAppId)

Write-host "AzGovViz service principal created successfully." -ForegroundColor Yellow

##--------------------------------------------------##

# Grant admin consent using the Microsoft Entra admin center.
Write-host "Grant admin consent using the Microsoft Entra admin center and then proceed with the next steps." -ForegroundColor Yellow

##--------------------------------------------------##

# Login to your GitHub account.
# Create a private repository from the accelerator template

### Create a new repository from template
gh repo create $GitHubRepository --template Azure/Azure-Governance-Visualizer-Accelerator --private
New-Item -ItemType Directory -Path $directoryToCloneAccelerator -Force
cd $directoryToCloneAccelerator
gh repo clone "$GitHubOrg/$GitHubRepository"
Set-Location $GitHubRepository

# Configure federated credentials for the service principal created in the first step
$gitHubRef= ":ref:refs/heads/main"
$subject = "repo:$gitHubOrg/$GitHubRepository$gitHubRef"
$body = @"
{
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "subject":"$subject",
  "issuer":"https://token.actions.githubusercontent.com",
  "name":"AzGovVizCreds"
}
"@

AzAPICall -method POST -body $body -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications/$AzGovVizAppObjectId/federatedIdentityCredentials" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel 'eventual'

##--------------------------------------------------##

# Grant permissions in Azure for the AzGovViz service principal created in the first step
New-AzRoleAssignment `
-ApplicationId $AzGovVizAppId `
-RoleDefinitionName "Reader" `
-Scope /providers/Microsoft.Management/managementGroups/$managementGroupId

##--------------------------------------------------##

# Create a Microsoft Entra application for user authentication to the Azure Web App that will host AzGovViz
# 2-60 Alphanumeric, hyphens and Unicode characters. Can't start or end with hyphen. A web site must have a globally unique name.

$body = @"
{
  "DisplayName":"$WebApplicationAppName",
  "web": {
    "redirectUris": [
      "https://$webAppName.azurewebsites.net/.auth/login/aad/callback"
    ],
    "implicitGrantSettings": {
      "enableIdTokenIssuance": true
    }
  }
}
"@


$webAppSP = AzAPICall -method POST -body $body -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel 'eventual'
$webAppSPAppId = $webAppSP.appId
$webAppSPObjectId = $webAppSP.Id

do {
  Write-Host "Waiting for the Azure WebApp app registration to get created..."
  Start-Sleep -seconds 30
  $webApp = AzAPICall -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications/$webAppSPObjectId" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel 'eventual'
} until ( $null -ne $webApp)

Write-host "Azure Web App app registration created successfully."

##--------------------------------------------------##

# Add an API scope for the Web App
$body = @"
{
  "identifierUris" : [
    "api://$webAppSPAppId"
  ],
  "api": {
    "oauth2PermissionScopes": [
      {
        "value": "user_impersonation",
        "adminConsentDescription": "AzGovViz Web App Microsoft Entra ID authentication",
        "adminConsentDisplayName": "AzGovViz Web App Microsoft Entra ID authentication",
        "type": "User",
        "id": "$webAppSPAppId"
      }
    ]
  }
}
"@

AzAPICall -method PATCH -body $body -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications/$webAppSPObjectId" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel 'eventual'

##--------------------------------------------------##

# Generate client secret
$body = @"
{
  "passwordCredential":{
    "displayName": "AzGovVizWebAppSecret"
  }
}
"@

$webAppSPAppSecret = (AzAPICall -method POST -body $body -uri "$($azAPICallConf['azAPIEndpointUrls'].MicrosoftGraph)/v1.0/applications/$webAppSPObjectId/addPassword" -AzAPICallConfiguration $azAPICallConf -listenOn 'Content' -consistencyLevel 'eventual').secretText

##--------------------------------------------------##

# Create a resource group and assign necessary RBAC roles
Select-AzSubscription -SubscriptionId $subscriptionId
New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags
New-AzRoleAssignment -ApplicationId $AzGovVizAppId -RoleDefinitionName "Web Plan Contributor" -ResourceGroupName $resourceGroupName
New-AzRoleAssignment -ApplicationId $AzGovVizAppId -RoleDefinitionName "WebSite Contributor" -ResourceGroupName $resourceGroupName

##--------------------------------------------------##

# Create the GitHub secrets, variables, and permissions
$subscriptionId = $subscriptionId
$tenantId = $tenantId
$managementGroupId = $managementGroupId
$resourceGroupName = $resourceGroupName
$clientId = $AzGovVizAppId
$webAppClientId = $webAppSPAppId
$webAppClientSecret = $webAppSPAppSecret

# Create GitHub repository secrets and variables
gh secret set 'CLIENT_ID' -b $clientId
gh secret set 'ENTRA_CLIENT_ID' -b $webAppClientId
gh secret set 'ENTRA_CLIENT_SECRET' -b $webAppClientSecret
gh secret set 'SUBSCRIPTION_ID' -b $subscriptionId
gh secret set 'TENANT_ID' -b $tenantId
gh secret set 'MANAGEMENT_GROUP_ID' -b $managementGroupId
gh variable set 'RESOURCE_GROUP_NAME' -b $resourceGroupName
gh variable set 'WEB_APP_NAME' -b $webAppName

##--------------------------------------------------##

# Configure GitHub actions permissions
gh api -X PUT /repos/$GitHubOrg/$GitHubRepository/actions/permissions/workflow -F can_approve_pull_request_reviews=true

##--------------------------------------------------##

```
