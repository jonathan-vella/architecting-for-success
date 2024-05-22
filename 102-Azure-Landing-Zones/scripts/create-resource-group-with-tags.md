# Create an Azure Resource Group with Tags

This script creates an Azure Resource Group with tags. The script uses the `New-AzResourceGroup` cmdlet to create the resource group and the `-Tags` parameter to assign tags to the resource group.

```powershell
# Declare your variables
$name = "rg-<unique>"
$location = "eastus"
$tags = @{environment= "dev"; costcenter= "shared"; workload="aks-demo"; owner="jonathan"}
```

## Script

```powershell
# Create a Resource Group with Tags
New-AzResourceGroup -Name $name -Location $location -Tag $tags
```

## Script

```powershell
# Add a new set of tags to a resource group, use:
$newtags = @{"Dept"="Finance"; "Status"="Normal"}
$resourceGroup = Get-AzResourceGroup -Name $name
New-AzTag -ResourceId $resourceGroup.ResourceId -tag $newtags
```

## Script

```powershell
# Update the tags for a resource group, use:
$updatedtags = @{"CostCenter"="00123"; "Environment"="Production"}
$resourceGroup = Get-AzResourceGroup -Name $name
Update-AzTag -ResourceId $resourceGroup.ResourceId -Tag $updatedtags -Operation Merge
```

