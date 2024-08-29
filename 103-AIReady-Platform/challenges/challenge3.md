# Architecting for Success - Azure Landing Zones

---

## Challenge 03 - Tailoring Azure Landing Zones (1.5hrs)

---

The ALZ reference implementations are based on the best practices and learnings of Microsoft teams from engagements with customers and partners. This knowledge represents the "80" side of the 80/20 rule. The various implementations take positions on technical decisions that are part of the architecture design process.

Because not all use cases are the same, not all organizations can use an implementation approach in the exact way it was intended. In this challenge you will need to tailor the customer's landing zone to meet their [requirements](./../docs/contoso-alz-customer-scenario.md).

## Challenge 03 - Success Criteria

Using a [policy-driven](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance) governance approach, you must:

1. Implement regional restrictions which require that all resources can only be deployed in the EU.
2. Enforce the use of tagging to create cost-related reports for each workload based on workload, application, owner, classification, costcenter and environment.
3. Implement ISO 27001 compliance security checks and reporting for all production environments except Sandbox subscriptions & PCI-DSS for the payment system.
4. Allow the use of M-Series VMs only for the SAP production environment without impacting agility and scale.
5. Deny the use of Machine Learning services across all environments to minimize the risk and impact of cryptojacking.
6. Deny the use of Private DNS Zones in the Landing Zones Management Group.
7. Ensure that "development environments and associated VNETs are not able to communicate with production".
8. Ensure that resources under the "Online" management group cannot establish cross-subscription inter-vnet communications.
9. Grant developers access to development environments at scale and with minimal administrative effort.
10. Create cost management alerts for budget (set value at $1000 and alerts from 75%-125%), forecast (75-125%) and anomalies.
    
> [!TIP]
> Explore the Azure Policy examples in this [folder](https://github.com/jonathan-vella/azure-landing-zones/tree/main/Az%20Policy%20Definitions).

---

## References

- [Tailoring Azure Landing Zones](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz)
- [Common Azure Policy examples](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/manage/azure-server-management/common-policies)
- [Azure Policy definitions for Tags](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-policies)
