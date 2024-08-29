<#
        .SYNOPSIS
        Resets Defender for cloud configuration to defaults for testing purposes

        .DESCRIPTION
        Resets Defender for cloud configuration to defaults for testing purposes.
        Takes prefix as a parameter to specify which Management Groups to target - the script will reset all subscriptions under that Management group.
        Alternatively, specify a single subscription with the subscriptionId parameter

        .EXAMPLE
        PS> Reset-DefenderForCloud.ps1 -Prefix 'lz-canary'

        .EXAMPLE
        PS> Reset-DefenderForCloud.ps1 -subscriptionId 'XXXXXXXX-XXXXX-XXXX-XXXX-XXXXXXXXXXXX'
#>

param (
    [String]
    $Prefix,
    [String]
    $subscriptionId
)

#Install-Module -Name Az.Security -Force -scope CurrentUser

If($prefix){
        #create an empty array to hold subscriptions
        $subscriptions = @()
        # Iterate Management Groups to get subscriptions
        ForEach ($mgmtGrp in Get-AzManagementGroup){

            #Filter Management Groups on Prefix
            If($mgmtGrp.Name -match $Prefix){

                # query Azure Graph for subscriptions in the management group and add them to the arry of subscriptions
                $query = "ResourceContainers | where type =~ 'microsoft.resources/subscriptions' |  mv-expand managementGroupParent = properties.managementGroupAncestorsChain | where managementGroupParent.name =~ '$($mgmtGrp.Name)'"
                $graphResult = Search-AzGraph -Query $Query -ManagementGroup $mgmtGrp.Name -First 200
                if(($graphResult.count -gt 0) -and ( $graphResult.properties.state -eq 'enabled')){$subscriptions += $graphResult.subscriptionid}
            }
        }

        # clean array to get unique subscriptions
        $subscriptions = $subscriptions | select-object -Unique
}
ElseIf($subscriptionId){
    $subscriptions = (Get-AzSubscription -SubscriptionId $subscriptionId).Id
}
Else{
    write-error "Specify either the -Prefix or -subscriptionId when calling this script"
    exit
}

Foreach($subscription in $subscriptions){
    #select azure subscription to configure
    Select-AzSubscription -Subscription $subscription

    # Reset Defender Plans to Free Tier
    foreach($defenderPlan in Get-AzSecurityPricing){
        write-output "Resetting Defender for Cloud plan: $($defenderPlan.Name) to the Free Tier"
        Set-AzSecurityPricing -Name $defenderPlan.Name -PricingTier "Free"
    }

    # turn auto-provisioning off
    foreach($setting in Get-AzSecurityAutoProvisioningSetting){
        write-output "Turning off autoprovisioning for: $($setting.name)"
        Set-AzSecurityAutoProvisioningSetting -Name $setting.name
    }

    # remove log analytics workspace
    foreach($workspace in Get-AzSecurityWorkspaceSetting){
        write-output "Removing default log analytics workspace: $($workspace.name)"
        Remove-AzSecurityWorkspaceSetting -Name $workspace.name
    }

    # Add more settings to configure below
}