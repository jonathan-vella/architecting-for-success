# Architecting for Success

# Enterprise Kubernetes Regulated Cluster Whiteboard Design Session - Case Study

### Customer situation

Contoso Payment Services Ltd. is a multinational corporation, headquartered in Europe that provides payment services solutions. They have data centres and branch offices scattered across Europe.

Consoso seeks to maximize the cost-effectiveness and flexibility of its IT, especially in new projects. Contoso has a large number of business units, each with its own unique IT requirements. The costs of internal hardware and data centre investment are ballooning. As a result, Contoso has decided to move their current workloads to the cloud and all future developments should follow a cloud native approach.

They are interested in a large-scale solution that will help mitigate creeping costs and start the transition to a modern cloud-based enterprise architecture.

Their workloads should be fully compliant with the Payment Card Industry Data Security Standard (PCI DSS). Contoso must evaluate their environment for compliance gaps with respect to moving to Azure. 

In addition to the PCI DSS compliance requirements, they are expecting significant growth. They foresee the need to scale their system and are exploring moving their web applications, corporate and data collection web apps, to Microsoft Azure via lift and shift and other applicable methods to simplify some of the operations management overhead and associated costs. They would also like to ensure that the workloads of different business units are sufficiently isolated. Lastly, they want to ensure that resources are created using best practices and that those practices are followed during the resource provisioning process.

The CTO, is aware of the cloud potentials, but also has a keen understanding that without strong governance, they may end up with an environment that lacks essential business controls. These incorrect practices can then be disbursed across the enterprise, leading to an unmanageable Azure estate and costs which are hard to track or control. He wants to start on the right foot by enforcing best practices from the start.

To kick off planning for integrating Azure into their environment, the CTO introduced you to several directors within the Enterprise IT group that have been part of the initial Azure planning process.

Enterprise IT is responsible for managing corporate network connectivity, datacentre distribution, capacity planning, identity, enterprise wide SaaS services, supporting services and audit policies.

To help drive Azure adoption and best practices, the CTO chartered a Cloud Governance team within Enterprise IT. This team will be responsible for all aspects of Azure governance. This includes defining, implementing and enforcing cloud governance and working with other teams to ensure best practices are adopted.

Rather than re-invent the wheel, the Cloud Governance team decided to adopt Microsoft's Cloud Adoption Framework as a baseline upon which they will build their governance implementation.

The Cloud Governance team is in the process of finalizing the actionable plan for their cloud adoption strategy. The plan will guide their technical efforts and be in full alignment of their business strategy.

The best approach for migrating to the cloud, based on their digital estate is to utilize Azure Kubernetes Services as the orchestrator for hosting their stateless applications. The majority of their applications are containerized.

### Customer needs

#### Security

1. AKS cluster should not have any public IP addresses.
2. Limit access of AKS cluster from an internal network, and continue to support VPN access.
3. Incoming traffic and traffic between application components should be encrypted with TLS
4. Make sure that pods from different namespaces cannot communicate with each other
5. Make sure that the services pods (APIs) can only be accessed by the front end pods or the ingress controller pods.
6. Ability to scale automatically as the company grows and system load increases.
7. Use private container registry with support of container image scanning.
8. Sensitive parameters should not be stored in the Kubernetes cluster, but in a secret store.
9. Application workloads should be separated from control plane workloads.
10. Ability to use ingress controller that does not consume compute power from the cluster.
11. Protect all your web apps from common web-hacking techniques such as SQL injection and security vulnerabilities such as cross-site scripting.
12. Control and secure the outbound traffic.
13. Continuously assess AKS cluster to provide visibility into misconfigurations and guidelines to help mitigate identified threats.
14. Use cluster and nodes threat protection by generating security alerts for suspicious activities.

#### Governance

1. Continually review and assign legal compliance tasks and provide a compliance reporting ability for Azure resources.
2. Enforce cluster pod security restricted standards for Linux-based workloads.
3. Enforce cluster pod security baseline standards for Linux-based workloads.
4. Use images from trusted registries to reduce the Kubernetes cluster's exposure risk to unknown vulnerabilities, security issues and malicious images.
5. Ensure that no Load Balancer services with a public IP address can be created in the Kubernetes cluster.
6. Ensure that access to the application over the ingress controller is encrypted with SSL.

#### Observability

1. Enable logging across all components to support an all-encompassing monitoring solution.
2. Provide tooling to help them with monitoring and managing container health and security.
3. Display cluster metrics graphically.
4. Enhance the logged data from the application to give the developers a more complete picture of the application's performance and behavior.
5. Implement proactive diagnostics to generate automatic alerts for unusual application behavior including unusual request response time, dependency response time, and page load time.

#### Scalability

1. The cluster should auto scale based on demand.
2. Control pod scaling on resource utilization.

#### Identity and Access Control

1. Ensure that Azure admins utilize best practices when accessing the Azure resources and that all logins are logged for identity theft analysis activities.
2. Kubernetes administrators must authenticate to the cluster using their AAD credentials.
3. Kubernetes authorization on resource level (i.e namepsace) should be managed through an Identity provider.

#### Operations

1. Be able to test functionality before pushing it to production systems.
2. Be able to automatically and continuously deploy new software builds.
3. Ensure that continuously deployed builds to the cloud do not interfere with the production system.
4. Use pull based approach to reconcile configuration changes without exposing cluster endpoints to the build agents.
5. Keep Azure Kubernetes Service (AKS) nodes up to date with the latest security patches or supported Kubernetes versions.

#### Business Continuity

1. Ensure that the workloads remains functional in case of Data Centre failure.
2. Kubernetes API Server should have a guarantee uptime of 99.95%
3. Ability but not a hard requirement to failover to another region in case of disaster.
4. Spin-off a new cluster including all the configuration easily.
5. Bakcup strategy for Kubernetes resources and persistent volumes.

### Customer objections

1. We've been told that Azure's services, like Azure SQL Database, Azure Storage and Key Vault, must always have a public endpoint. Is that really true?
2. How can Azure help control the costs associated with non-Production clusters left running out-of-hours?
3. We have invested heavily in a third-party backup solution but we want to utilize Azure backup capabilities. Does Azure support this?
4. We heard about Managed Identities. We would like to understand how it would improve the security of the solution you are recommending to us.
5. Microsoft does their best for securing the Azure network, but we are unsure how to detect when hackers are attacking our systems. How will Microsoft's solution ensure we have visibility into our security posture?
6. Does Azure allow enough granular Kubernetes RBAC controls to meet our least privilege needs?
8. It is not clear to us ,how Azure helps our solution become PCI compliant. How can we ensure continued PCI DSS compliance?
9. The new system may require querying data from on-premises data sources, how do you bridge that gap?
10. What is meant by a pull pipeline? How is it different from a push pipeline? 
11. We have been told that we can use authorized IP ranges accessing our Kubernetes API server. Can we use this functionality to limit API server access from specific IPs in a private cluster?
12. Somebody in the Enterprise IT team had an issue in the past with asymmetric routing when enabling Azure Firewall to control outbound traffic from AKS cluster resources. How can we bypass this issue?
13. We are not sure what network model to use in our cluster. During our investigation we realize that we can use Azure CNI, Kubenet and Azure CNI overlay. Which networking option should we choose for our AKS cluster.

### Infographic for common scenarios

_Kubernetes Architecture_

> **Note**: This reference implementation demonstrates the *recommended starting (baseline) infrastructure architecture* for an AKS cluster that is under regulatory compliance requirements (such as PCI). This implementation builds directly upon the [AKS Baseline Cluster reference implementation](https://github.com/mspnp/aks-baseline) and adds to it additional implementation points that are more commonly seen in regulated environments vs typical "public cloud" consumption patterns.The reference architecture and implementation have not been certified by an official authority. By completing this series and deploying the code assets, you do not clear audit for PCI DSS. Acquire compliance attestations from third-party auditor.

[<img src="../../images/regulated-architecture.svg" width="600"/>](../../images/regulated-architecture.svg)

<https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-pci/aks-pci-ra-code-assets>

_Workload HTTPS request flow_

[<img src="../../images/flow.svg" width="600"/>](../../images/flow.svg)

<https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-pci/aks-pci-ra-code-assets#tls-encryption>

_Use GitOps with Flux, GitHub, and AKS to implement CI/CD_

[<img src="../../images/gitops-ci-cd-flux.png" width="600"/>](../../images/gitops-ci-cd-flux.png)

<https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks#scenario-2-use-gitops-with-flux-github-and-aks-to-implement-cicd>
