# Create Azure Resource Group with Tags

# Define variables
name = "rg-<unique>"
location = "eastus"
tags = "@{environment=dev; costcenter=shared; workload=aks-demo; owner=jonathan}"

# Create a Resource Group with Tags
New-AzResourceGroup -Name $name -Location $locationlocation> -Tag $tags

# Add a new set of tags to a resource group, use:
$newtags = @{"Dept"="Finance"; "Status"="Normal"}
$resourceGroup = Get-AzResourceGroup -Name demoGroup
New-AzTag -ResourceId $resourceGroup.ResourceId -tag $newtags

# Update the tags for a resource group, use:
$updatedtags = @{"CostCenter"="00123"; "Environment"="Production"}
$resourceGroup = Get-AzResourceGroup -Name demoGroup
Update-AzTag -ResourceId $resourceGroup.ResourceId -Tag $updatedtags -Operation Merge