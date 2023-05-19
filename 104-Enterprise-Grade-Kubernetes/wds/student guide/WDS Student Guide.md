# Architecting for Success

# Enterprise Kubernetes Regulated Cluster Whiteboard Design Session student guide

**Contents**

<!-- TOC -->

- [Enterprise Kubernetes Regulated Cluster whiteboard design session student guide](#\insert-workshop-name-here\-whiteboard-design-session-student-guide)
  - [Abstract and learning objectives](#abstract-and-learning-objectives)
  - [Step 1: Review the customer case study](#step-1-review-the-customer-case-study) (15 mins)
    - [Case Study](./CaseStudy.md)
  - [Step 2: Design a proof of concept solution](#step-2-design-a-proof-of-concept-solution) (45 mins)
  - [Step 3: Present the solution](#step-3-present-the-solution)  (15 mins)
  - [Wrap-up](#wrap-up) (Optional 15 mins)
  - [Additional references](#additional-references)

<!-- /TOC -->

## Abstract and learning objectives

In this whiteboard design session, you will learn how to design an Enterprise Kubernetes Regulated Cluster architecture for Contoso. You will be working through the customer scenario and their particular requirements to produce a tailored architecture for their deployment.

This session will help you consider the baseline requirements of a regulated cluster and guide you on how to run sensitive workloads in an Azure Kubernetes Service (AKS) cluster.

## Step 1: Review the customer case study

**Outcome**

Analyze your customer's needs.

Timeframe: 15 minutes

Directions: With all participants in the session, the facilitator/SME presents an overview of the customer case study along with technical tips.

1. Meet your team members and trainer.

2. Read all directions for steps 1-3 in the student guide.

3. As a team, review the [customer case study](./CaseStudy.md)

## Step 2: Design a proof of concept solution

**Outcome**

Design a solution and prepare to present the solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 45 minutes

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

Prepare a 15-minute chalk-talk style presentation to the customer.

## Step 3: Present the solution

**Outcome**

Present a solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 15 minutes

**Presentation**

Directions:

1. Pair with another team.

2. One group is the solution design team, the other is the customer.

3. The solution design team presents their proposed solution to the customer.

4. The customer makes one of the objections from the list of objections.

5. The solution design team responds to the objection.

6. The customer team gives feedback to solution design team.

7. (Optional) Switch roles and repeat Steps 2-6.

## Wrap-up (Optional)

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
