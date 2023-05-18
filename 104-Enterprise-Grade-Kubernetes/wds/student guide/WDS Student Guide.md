# Architecting for Success

# Enterprise Kubernetes Regulated Cluster Whiteboard Design Session student guide

**Contents**

<!-- TOC -->

- [Enterprise Kubernetes Regulated Cluster whiteboard design session student guide](#\insert-workshop-name-here\-whiteboard-design-session-student-guide)
  - [Abstract and learning objectives](#abstract-and-learning-objectives)
  - [Step 1: Review the customer case study](#step-1-review-the-customer-case-study)
    - [Customer situation](#customer-situation)
    - [Customer needs](#customer-needs)
    - [Customer objections](#customer-objections)
    - [Infographic for common scenarios](#infographic-for-common-scenarios)
  - [Step 2: Design a proof of concept solution](#step-2-design-a-proof-of-concept-solution)
  - [Step 3: Present the solution](#step-3-present-the-solution)
  - [Wrap-up](#wrap-up)
  - [Additional references](#additional-references)

<!-- /TOC -->

## Abstract and learning objectives

In this whiteboard design session, you will learn how to design an Enterprise Kubernetes Regulated Cluster architecture for Contoso. You will be working through the customer scenario and their particular requirements to produce a tailored architecture for their deployment.

This session will help you consider the baseline requirements of a regulated cluster and guide you on how to run sensitive workloads in an Azure Kubernetes Service (AKS) cluster.

## Step 1: Review the customer case study

**Outcome**

Analyze your customer's needs.

Timeframe: 10 minutes

Directions: With all participants in the session, the facilitator/SME presents an overview of the customer case study along with technical tips.

1. Meet your team members and trainer.

2. Read all directions for steps 1-3 in the student guide.

3. As a team, review the following customer case study.

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
10. Ability to use ingress controllers that does not consume compute power from the cluster.
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

## Step 2: Design a proof of concept solution

**Outcome**

Design a solution and prepare to present the solution to the target customer audience in a 10-minute chalk-talk format.

Timeframe: 30 minutes

**Business needs**

Directions: With your team, answer the following questions and be prepared to present your solution to others:

1. Who will you present this solution to? Who is your target customer audience? Who are the decision makers?

2. What customer business needs do you need to address with your solution?

**Design**

Directions: With your team, respond to the following questions:

_High-level architecture_

1. Without getting into the details, which you will address below, design a diagram with your initial vision for handling the top-level requirements.

_Security_

1. Based on the customer’s requirements, explain how to handle all the security aspects of the environment. Explain how to configure the cluster and what services to use.

_Governance_

1. Explain to the customer how you will enforce organizational standards and  assess compliance of your environment.
2. List all the compliance item assignments to use based on customer requirements.

_Observability_

1. How can you deliver a single consistent experience for log search, alerting, analytics and dashboarding?

2. What tools and services shall you use to cover customer requirements?

_Scalability_

1. Explain to the customer the AKS scaling capabilities to cover their requirements.

_Identity and Access Control_

1. With respect to managing access to the AKS Cluster, explain how you should implement the solution to meet their requirements.

_Operations_

1. How would you recommend to implement their automated deployments based on their requirement?

2. Describe the recommended approach for keeping Azure Kubernetes Service (AKS) nodes up to date with the latest security patches or supported Kubernetes versions.

_Business Continuity_

1. Describe how you would ensure that the following resources would be available in case of disaster based on their requirement.

2. Describe the backup strategy for Kubernetes resources and persistent volumes.

**Prepare**

Directions: As a team:

1. Identify any customer needs that are not addressed with the proposed solution.

2. Identify the benefits of your solution.

3. Determine how you will respond to the customer's objections.

Prepare a 10-minute chalk-talk style presentation to the customer.

## Step 3: Present the solution

**Outcome**

Present a solution to the target customer audience in a 10-minute chalk-talk format.

Timeframe: 10 minutes

**Presentation**

Directions:

1. Pair with another team.

2. One group is the solution design team, the other is the customer.

3. The solution design team presents their proposed solution to the customer.

4. The customer makes one of the objections from the list of objections.

5. The solution design team responds to the objection.

6. The customer team gives feedback to solution design team.

7. (Optional) Switch roles and repeat Steps 2-6.

## Wrap-up

Timeframe: 10 minutes

Directions: Reconvene with the larger group to hear the facilitator/SME share the preferred solution for the case study.

## Additional references

|                                                            |                                                                                                                       |
| ---------------------------------------------------------- |:--------------------------------------------------------------------------------------------------------------------- |
| **Description**                                            | **Links**                                                                                                             |
| Azure Kubernetes Services (AKS)                            | <https://docs.microsoft.com/azure/aks/intro-kubernetes/>                                                              |
| Baseline architecture for an AKS cluster                   | <https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks/baseline-aks>            |
| Azure security baseline for AKS                            | <https://learn.microsoft.com/en-us/security/benchmark/azure/baselines/azure-kubernetes-service-aks-security-baseline> |
| AKS Baseline Cluster for Regulated Workloads               | <https://github.com/mspnp/aks-baseline-regulated/tree/main>                                                           |
| Introduction of an AKS regulated cluster for PCI-DSS 3.2.1 | <https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-pci/aks-pci-intro>       |
| Microsoft Defender for Containers                          | <https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction>                     |
| GitOps for Azure Kubernetes Service                        | <https://learn.microsoft.com/en-us/azure/architecture/example-scenario/gitops-aks/gitops-blueprint-aks#scenario-2-use-gitops-with-flux-github-and-aks-to-implement-cicd>                     |
| Autoscaling AKS                                            | <https://github.com/kubernetes/autoscaler>                                                                            |
| AKS Cluster Autoscaler                                     | <https://docs.microsoft.com/azure/aks/cluster-autoscaler>                                                             |
| Upgrading an AKS cluster                                   | <https://docs.microsoft.com/azure/aks/upgrade-cluster>                                                                |
| Azure Arc-enabled Kubernetes                               | <https://docs.microsoft.com/azure/azure-arc/kubernetes/overview/>                                                     |
| Azure Bastion                                              | <https://learn.microsoft.com/en-us/azure/bastion/bastion-overview>                                                    |
| Azure Key Vault                                            | <https://learn.microsoft.com/en-us/azure/key-vault/general/basic-concepts>                                            |
| Private Endpoints                                          | <https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview>                                      |
| Application Gateway with WAF                               | <https://learn.microsoft.com/en-us/azure/application-gateway/overview>                                                |
| Azure Firewall                                             | <https://learn.microsoft.com/en-us/azure/firewall/overview>                                                           |
| Azure Policy built-in definitions ofr AKS                  | <https://learn.microsoft.com/en-us/azure/aks/policy-reference>                                                        |
| Azure Container Registry                                   | <https://learn.microsoft.com/en-us/azure/container-registry/container-registry-intro>                                 |
| Access and identity options for AKS                        | <https://learn.microsoft.com/en-us/azure/aks/concepts-identity>                                                       |
| Monitor AKS with Azure Monitor                             | <https://learn.microsoft.com/en-us/azure/aks/monitor-aks>                                                             |
