# Architecting for Success - Customer objections / questions

1. We've been told that Azure's services, like Azure SQL Database, Azure Storage and Key Vault, must always have a public endpoint. Is that really true?
2. How can Azure help control the costs associated with non-Production clusters left running out-of-hours?
3. We have invested heavily in a third-party backup solution but we want to utilize Azure backup capabilities. Does Azure support this?
4. We heard about Managed Identities. We would like to understand how it would improve the security of the solution you are recommending to us.
5. Microsoft does their best for securing the Azure network, but we are unsure how to detect when hackers are attacking our systems. How will Microsoft's solution ensure we have visibility into our security posture?
6. Does Azure allow enough granular Kubernetes RBAC controls to meet our least privilege needs?
7. It is not clear to us ,how Azure helps our solution become PCI compliant. How can we ensure continued PCI DSS compliance?
8. The new system may require querying data from on-premises data sources, how do you bridge that gap?
9. What is meant by a pull pipeline? How is it different from a push pipeline? 
10. We have been told that we can use authorized IP ranges accessing our Kubernetes API server. Can we use this functionality to limit API server access from specific IPs in a private cluster?
11. Somebody in the Enterprise IT team had an issue in the past with asymmetric routing when enabling Azure Firewall to control outbound traffic from AKS cluster resources. How can we bypass this issue?
12. We are not sure what network model to use in our cluster. During our investigation we realize that we can use Azure CNI, Kubenet and Azure CNI overlay. Which networking option should we choose for our AKS cluster.
