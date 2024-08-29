<#
.DESCRIPTION
Remove all resource groups (and resources) from subscriptions in hierarchy up to and including prefix
#>
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [String]
    $Prefix
)

Get-AzManagementGroup | Where-Object Name -match "^$Prefix" | Sort-Object -Descending | ForEach-Object {
    $managementGroupName = $PSItem.Name
    $managementGroupDisplayName = $PSItem.DisplayName

    Write-Output "Checking subscriptions under management group '$managementGroupDisplayName'..."

    Get-AzManagementGroupSubscription -GroupName $managementGroupName | ForEach-Object {
        $subscriptionId = $PSItem.Id -split "/" | Select-Object -Last 1
        $subscriptionDisplayName = $PSItem.DisplayName
        Set-AzContext -SubscriptionId $subscriptionId | Out-Null
        Write-Output "Removing all resource groups (and resources) from subscription '$subscriptionDisplayName'..."
        Get-AzResourceGroup | ForEach-Object {
            $resourceGroupName = $PSItem.ResourceGroupName
            Write-Output "- $resourceGroupName"
            Remove-AzResourceGroup -Name $resourceGroupName -Force | Out-Null
        }
    }
}
