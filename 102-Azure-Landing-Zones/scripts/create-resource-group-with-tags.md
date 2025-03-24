# Create an Azure Resource Group with Tags

This PowerShell script creates an Azure Resource Group with tags. The script uses the `New-AzResourceGroup` cmdlet to create the resource group and the `-Tags` parameter to assign tags to the resource group.

```powershell
# Declare your variables
$name = "rg-lab-neu-001"
$location = "germanywestcentral"
$subscription = "sandbox"
$tags = @{"environment"= "dev"; "owner" = "jonathan"; "costcenter" = "shared"; "application" = "demo"; "workload" = "demo"; "sla" = ""; "backup-policy" = ""; "maint-window" = ""; "technical-contact" = "someone@somewhere.com"}
```

## Script

```powershell
# Set Context
set-azcontext -Subscription $subscription
# Create a Resource Group with Tags
New-AzResourceGroup -Name $name -Location $location -Tag $tags
```

## Script

```powershell
# Add a new set of tags to a resource group, use:
$newtags = @{"dept" = "finance"; "status" = "normal"} # Note: This variable must also include all of the tags which are being enforced by Azure Policy.
$resourceGroup = Get-AzResourceGroup -Name $name
New-AzTag -ResourceId $resourceGroup.ResourceId -tag $newtags
```

## Script

```powershell
# Update the tags for a resource group, use:
$updatedtags = @{"costcenter" = "00123"; "environment" = "production"}
$resourceGroup = Get-AzResourceGroup -Name $name
Update-AzTag -ResourceId $resourceGroup.ResourceId -Tag $updatedtags -Operation Merge
```

