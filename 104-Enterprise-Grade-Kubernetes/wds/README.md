# Architecting for Success  - Enterprise Kubernetes Regulated Cluster Whiteboard Design Session

Contoso Payment Services Ltd. is a multinational corporation, headquartered in Europe that provides payment services solutions. They have data centres and branch offices scattered across Europe.

Consoso seeks to maximize the cost-effectiveness and flexibility of its IT, especially in new projects. Contoso has a large number of business units, each with its own unique IT requirements. The costs of internal hardware and data centre investment are ballooning. As a result, Contoso has decided to move their current workloads to the cloud and all future developments should follow a cloud native approach.

They are interested in a large-scale solution that will help mitigate creeping costs and start the transition to a modern cloud-based enterprise architecture.

Their workloads should be fully compliant with the Payment Card Industry Data Security Standard (PCI DDS). Contoso must evaluate their environment for compliance gaps with respect to moving to Azure. 

In this whiteboard design session, you will learn how to design an Enterprise Kubernetes Regulated Cluster architecture for Contoso. You will be working through the customer scenario and their particular requirements to produce a tailored architecture for their deployment.

## Student Guide

In this whiteboard design session, you will learn how to design an Enterprise Kubernetes Regulated Cluster architecture for Contoso. You will be working through the customer scenario and their particular requirements to produce a tailored architecture for their deployment.

This session will help you consider the baseline requirements of a regulated cluster and guide you on how to run sensitive workloads in an Azure Kubernetes Service (AKS) cluster.

Follow the student guide: [White board design session student guide](./student%20guide/WDS%20Student%20Guide.md)

## Target audience

- Infrastructure Architect
- IT Professional
- DevOps Engineer
- Cloud Solution Architect

## Azure services and related products

- Azure Kubernetes Service
- Azure Policy
- Networking
- Private endpoints
- Azure Firewall
- Web Application Firewall
- Application Gateway
- Azure Key Vault
- Azure Container Registry
- Azure Defender
- Prometheus and Grafana
- Azure Monitor
- Azure Log Analytics
- Application Insights

## Infographics

- [Infographics](./student%20guide/Infographics.md)

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
