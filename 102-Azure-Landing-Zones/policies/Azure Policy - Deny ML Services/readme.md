# Audit or Deny the use of Machine Learning Services based on SKU

This policy can audit or deny the use of Azure Machine Learning Services based on SKU. Resource creation will be denied unless SKU and / or Target Type are explicitly defined in the policy. Combined with other policies which for example audit the use of M-Series and N-series VMs outside of ML Services, this policy can help mitigate the risk and minimize the impact of cryptojacking.

> Note: By default this policy is configure with a "deny" effect; this will not impact any existing resources. Other allowed values are "Audit" and "Disabled".

To import this policy you can either use the Azure Portal and copy & paste the content of "policy-name.json" into a new policy definition, or via Powershell:
```powershell
New-AzPolicyDefinition -Name "My Policy Name" -ManagementGroupName "My Mgmt Group" -Policy "policy.json"
```
The command creates a policy definition named "My Policy Name" in the Management Group "My Mgmt Group" using the "policy.json" file. For more information about other parameters that you can use, see [New-AzPolicyDefinition](https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azpolicydefinition).

When called without location parameters, New-AzPolicyDefinition defaults to saving the policy definition in the selected subscription of the sessions context. To save the definition to a different location, use the following parameters:

- SubscriptionId - Save to a different subscription. Requires a GUID value.
- ManagementGroupName - Save to a management group. Requires a string value.

My recommendation is to save the policy definition in a management group and assign the policy either to this same management group or to another management group further down your hierarchy.

![Figure 1: The four scope levels for organizing your Azure resources.](scope-levels.png)

> Note: If you apply any access or policy at one level in the hierarchy, it propagates down to the lower levels. If you apply this policy at a management group level, the subscription owner can't alter an inherited policy. This limitation helps improve governance.

## Additonal information:
- [Azure Policy Overview](https://docs.microsoft.com/en-us/azure/governance/policy/overview)
- [Resource Organization in the the Cloud Adoption Framework for Microsoft Azure](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org)
- [Best Practices for Azure RBAC](https://docs.microsoft.com/en-us/azure/role-based-access-control/best-practices) 


