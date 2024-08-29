<#
.DESCRIPTION
Remove all policies in hierarchy up to and including prefix
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", "", Justification = "False positive")]
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [String]
    $Prefix,

    [switch]
    $AssignmentsOnly
)

Get-AzManagementGroup | Where-Object Name -match "^$Prefix" | Sort-Object Name -Descending | ForEach-Object {
    $scope = $PSItem.Id
    $managementGroupName = $PSItem.Name
    $displayName = $PSItem.DisplayName

    Write-Output "Removing policy assignments from management group '$displayName'..."

    Get-AzPolicyAssignment -Scope $scope |
    Where-Object { $PSItem.Properties.Scope -eq $scope } |
    ForEach-Object {
        Write-Output "- $($PSItem.ResourceId)"
        Remove-AzPolicyAssignment -Name $PSItem.Name -Scope $scope | Out-Null
    }

    if (-not $AssignmentsOnly) {
        Write-Output "Removing initiatives from management group '$displayName'..."

        Get-AzPolicySetDefinition -ManagementGroupName $managementGroupName -Custom |
        Where-Object ResourceId -Match "^/providers/Microsoft.Management/managementGroups/$managementGroupName/" |
        ForEach-Object {
            Write-Output "- $($PSItem.ResourceId)"
            Remove-AzPolicySetDefinition -Name $PSItem.Name -ManagementGroupName $managementGroupName -Force | Out-Null
        }

        Write-Output "Removing policy definitions from management group '$displayName'..."

        Get-AzPolicyDefinition -ManagementGroupName $managementGroupName -Custom |
        Where-Object ResourceId -Match "^/providers/Microsoft.Management/managementGroups/$managementGroupName/" |
        ForEach-Object {
            Write-Output "- $($PSItem.ResourceId)"
            Remove-AzPolicyDefinition -Name $PSItem.Name -ManagementGroupName $managementGroupName -Force | Out-Null
        }
    }
}
