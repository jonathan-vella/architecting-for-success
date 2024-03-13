# Architecting for Success - Azure Landing Zones

---

## Challenge 03 - Tailoring Azure Landing Zones (1.5hrs)

---

The ALZ reference implementations are based on the best practices and learnings of Microsoft teams from engagements with customers and partners. This knowledge represents the "80" side of the 80/20 rule. The various implementations take positions on technical decisions that are part of the architecture design process.

Because not all use cases are the same, not all organizations can use an implementation approach in the exact way it was intended. In this challenge you will need to tailor the customer's landing zone to meet their [requirements](./../docs/contoso-alz-customer-scenario.md).

## Challenge 03 - Success Criteria

Using a [policy-driven](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance) governance approach, you must:

1. Implement regional restrictions which require that all resources can only be deployed in the EU.
2. Enforce the use of tagging to create cost-related reports for each workload based on workload, application, department, owner, criticality, classification, and environment.
3. Implement ISO 27001 compliance security checks and reporting for all production environments except Sandbox subscriptions & PCI-DSS for the payment system.
4. Allow the use of M-Series VMs only for the SAP production environment without impacting agility and scale.
5. Deny the use of Machine Learning services across all environments to minimize the risk and impact of cryptojacking.
6. Ensure that "development environments and associated VNETs are not able to communicate with production".
7. Ensure that resources under the "Online" management group cannot establish cross-subscription inter-vnet communications.
8. Grant developers access to development environments at scale and with minimal administrative effort.
9.  
   > [!TIP]
   > You might find a sample Azure Policy [here](https://github.com/jonathan-vella/azure-landing-zones/tree/main/Az%20Policy%20Definitions).

---

## References

[Tailoring Azure Landing Zones](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/tailoring-azure-landing-zones)
[Common Azure Policy examples](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/common-azure-policy-examples)
