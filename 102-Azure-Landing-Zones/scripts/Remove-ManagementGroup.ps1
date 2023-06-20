<#
.DESCRIPTION
Remove all management groups in hierarchy up to and including prefix
#>
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [String]
    $Prefix
)

$tenantId = (Get-AzContext).Tenant.Id

Get-AzManagementGroup | Where-Object Name -match "^$Prefix" | Sort-Object -Descending | ForEach-Object {
    $managementGroupName = $PSItem.Name
    $managementGroupDisplayName = $PSItem.DisplayName

    Write-Output "Checking subscriptions under management group '$managementGroupDisplayName'..."

    Get-AzManagementGroupSubscription -GroupName $managementGroupName | ForEach-Object {
        $subscriptionId = $PSItem.Id -split "/" | Select-Object -Last 1
        Write-Output "Moving subscription '$managementGroupDisplayName' to /..."
        New-AzManagementGroupSubscription -GroupName $tenantId -SubscriptionId $subscriptionId | Out-Null
    }

    Write-Output "Removing management group '$managementGroupDisplayName'..."
    Remove-AzManagementGroup -GroupName $managementGroupName | Out-Null
}
