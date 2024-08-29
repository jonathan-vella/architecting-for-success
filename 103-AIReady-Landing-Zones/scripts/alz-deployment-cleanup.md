# Clean up your previous Azure Landing Zones deployments

 If you are using AAD Tenant where you have previously deployed ALZ and wish to use a region other than the one you used in your previous deployment, we highly recommend to clean up your previous ALZ deployments.

 This is one-off time activity to ensure there are no conflicts.

---

Please use following PowerShell commands to clear all deployments at tenant, Management Group and Subscription scopes.

```powershell
Get-AzTenantDeployment   | Foreach-Object -Parallel {
    Write-Verbose "$(Get-Date) Removing Tenant Deployment $($_.Id)"
    Stop-AzTenantDeployment -Id $_.Id -Confirm:$false -ErrorAction:SilentlyContinue
    Remove-AzTenantDeployment -Id $_.Id
}

Get-AzManagementGroup   | Foreach-Object -Parallel {
    Get-AzManagementGroupDeployment -ManagementGroupId $_.Name |  Foreach-Object -Parallel {
        Write-Verbose "$(Get-Date) Removing Management Group Deployment $($_.Id)"
        Stop-AzManagementGroupDeployment -Id $_.Id -Confirm:$false -ErrorAction:SilentlyContinue
        Remove-AzManagementGroupDeployment -Id $_.Id
    }
}

Get-AzSubscription | ForEach-Object {
    Set-AzContext -SubscriptionId $_.SubscriptionId | out-null
    Get-AzSubscriptionDeployment |  Foreach-Object -Parallel {
        Write-Verbose "$(Get-Date) Removing Subscription Deployment $($_.Id)"
        Stop-AzSubscriptionDeployment -Id $_.Id -Confirm:$false -ErrorAction:SilentlyContinue
        Remove-AzSubscriptionDeployment -Id $_.Id
    }
}

```

---
