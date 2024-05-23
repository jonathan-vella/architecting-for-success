# Architecting for Success - Azure Landing Zones

---

## Challenge 04 - BCDR at scale (1.5hrs)

---

## Challenge 04a - Azure VM Backup at scale (1hr 15mins)

But I am in the cloud, why do I need BCDR? Because shit happens. With that clarified we can proceed with the challenge. In the first part of this challenge you will auto-enable backup and DR on VM creation using Azure Policy. Regarding backup, remember that the customer's requirement is to have "all **production** VMs backed up, and **some** selected VMs in dev/test environments" to be protected at least on a **weekly basis**. Your solution must clearly address all of these requirements whilst minimizing management tasks and limiting the blast radius during incidents which require the use of Azure Backup and Azure Site Recovery.

> [!TIP]
> Use the helper scripts located [here](./../scripts) to create Resource Groups with Tags and VNETs with NSGs. And remember that Azure Policy assignments can take up to 30 minutes to take effect!

## Challenge 04a - Success Criteria

1. Think before you act:
   - Under which Management Group is your subscription nested?
   - Which are the Azure Policy impacting your subscription?
   - Will some of these Azure Policy assignment make this challenge more difficult to complete?
   - Do you need to change anything?
   - And which Azure Policy for Azure Backup are you going to use meet the customer's requirement?
3. Configure Azure Backup (e.g., vault, policy, etc.)
4. Use Azure Policy to auto-enable backup on VM creation but to also audit for non-compliance
5. Use Azure Policy to auto-enable DR on VM creation but to also audit for non-compliance
6. Deploy an Azure VM and make sure that the VM is enabled for BCDR (Azure Backup and Azure Site Recovery) via Azure Policy
7. In the Azure Portal, have a look at your VM's blade and note what else the VM has been automatically onboarded into (e.g., VMInsights, MDfC, etc.).
8. Be able to answer these 2 questions: At which scope can these policies be applied? And what are you doing to clearly and easily identify "all **production** VMs backed up, and **some** selected VMs in dev/test environments"?

---

## Challenge 04b - Azure SQL DB BCDR at scale (15mins)

In the second part of this challenge you will be creating a custom Azure Policy definition which can audit the PITR backup configuration of Azure SQL Databases and / or if the PITR is not set to the user-specified number of days (e.g., 7 days), the policy will remediate this setting.

## Challenge 04b - Success Criteria

1. Create an Azure Policy definition which can support the auditing and / or configuration of Azure SQL Database PITR. You can use the code located [here](https://raw.githubusercontent.com/jonathan-vella/azure-landing-zones/main/Az%20Policy%20Definitions/Configure%20Azure%20SQL%20PITR/Deploy%20Azure%20SQL%20DB%20ShortTerm%20Backup.json) to create this policy or write your own.
2. Create the required Azure Policy assignments.
3. Create an Azure SQL Database (use the Adventureworks Database) and monitor the impact of the Azure Policy in scope for this challenge.

## References

- [Policies included in Azure Landing Zones reference implementations](https://github.com/Azure/Enterprise-Scale/wiki/ALZ-Policies)
- [Auto-Enable Backup on VM Creation using Azure Policy](https://learn.microsoft.com/en-us/azure/backup/backup-azure-auto-enable-backup)
- [Use Azure Policy to set up Azure Site Recovery](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-how-to-enable-policy)
- [Automated backups in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/automated-backups-overview?view=azuresql)
- [Create a single Azure SQL database](https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql&tabs=azure-portal)

