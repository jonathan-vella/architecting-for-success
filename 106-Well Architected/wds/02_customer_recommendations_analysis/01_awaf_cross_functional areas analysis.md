# Architecting for Success

---

## 106 - Microsoft Azure Well Architected Workshop

---

## A Well-Architected Framework cross-functional areas analysis

**Overview**

This unit contains a five-part whiteboarding exercise focused on key cross-functional areas within a Well-Architected Framework. After completing this exercise, you'll then wrap up with a team discussion to summarize the themes and key takeaways from your brainstorming.

**Objective**

By the end of this unit, you will be able to:
• Outline customer needs, business priorities, and key architectural characteristics given a realistic customer workload.
• Conduct a cross-pillar analysis and determine key gaps in the workload's alignment with the Well-Architected Framework.

**Participant guidance**

In this phase, **get all your ideas down on paper**. Once you've completed the whiteboarding session, your team will work together to refine and prioritize your recommendations.

---

### Part 1: Brainstorm solutions related to resiliency within a Well-Architected Framework

Team lead guidance
* This whiteboard will be completed collaboratively using the provided table.
* Encourage all members to brainstorm and share their ideas on how to make the current architecture more resilient.
* You may choose to start the discussion by level-setting with your team on the basics of resiliency by reviewing the provided resources.
* Assign a timekeeper so your team gets through all of the topics before the end of the session.

Overview

The first step in this whiteboard will be to discuss resiliency. To do this, walk through the high-level architecture of how the customer's current architecture fits within the broader environment to determine internal and external dependencies, service-level agreements and service-level objectives (SLA/SLOs), and failure modes. Analyze how business continuity and disaster recovery requirements are being addressed by the workload architecture and operational strategies.

**Resources**

**Characteristics of resiliency**

* Availability targets [(target and nonfunctional requirements)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/design-requirements#availability-targets)
  * Service-level agreement (SLA)
    * Composite SLA [(business metrics)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/business-metrics#composite-slas)
  * Mean time between failures (MTBF)
  * Mean time to recover (MTTR)
* Failure mode analysis [(resiliency and dependencies)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/design-resiliency#build-resiliency-with-failure-mode-analysis)
  * Internal and external dependencies
    * Individual SLAs
  * Single points of failure
* Fault tolerance
  * Availability and high availability design patterns [(reliability patterns)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/reliability-patterns)
  * Data management [(data management for reliability)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/data-management)
  * Fault injection [(test apps for availability and resiliency)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/testing#fault-injection-testing)
    * Chaos engineering [(chaos engineering)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/chaos-engineering)
* Backup and recovery [(backup and disaster recovery for apps)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/backup-and-recovery)
  * Recovery targets [(target and nonfunctional requirements)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/design-requirements#recovery-targets)
    * Recovery time objective (RTO)
    * Recovery point objective (RPO)
* Disaster recovery plan
* Backup strategy
* Capacity planning [(plan for capacity)](https://learn.microsoft.com/en-us/azure/architecture/framework/scalability/design-capacity)

**Participant guidance**

1. Brainstorm about how the customer's current architecture fits within the broader environment to determine internal and external dependencies, service-level agreements and service-level objectives (SLA/SLOs), and failure modes.
2. Analyze how business continuity and disaster recovery (BCDR) requirements are being addressed by the workload architecture and operational strategies.
3. Focusing on factors related to resiliency, share all ideas that come to mind for how the customer's current PaaS or IaaS architecture could be made more efficient.
4. To guide your analysis, consider the provided resources and the following resiliency-related questions:
   * What are the internal and external dependencies that are critical to workload operations and reliability?
   * What are the SLAs/SLOs for these dependencies?
   * Do any of the failure modes around these dependencies directly affect the reliability of the workload?
   * What are the functional and nonfunctional requirements for BCDR relative to the workload?
   * How does the architecture align to a BCDR strategy that meets those requirements?
   * Does the architecture allow for automated and routine testing of the BCDR strategy?

**Duration**: 30 minutes

**Participant steps**

1. Work in the "Resiliency" topic column.
2. Answer the resiliency questions using the information included in the customer scenario and your own experiences.
3. Complete the resiliency-related fields in the whiteboard.
4. Go to the next activity to continue with the Well-Architected Framework analysis.

**Tips**

To help you answer the questions, consider the following characteristics that determine an architecture's resiliency. These include:
* Availability targets
* Failure mode analysis
* Fault tolerance
* Backup and recovery
Refer to the resources section for more information about these topics.

**Summary**

This brainstorming session focused on solutions related to resiliency. Next, you'll focus on performance and scale.

--

### Part 2: Brainstorm solutions related to performance and scale within a Well-Architected Framework

**Overview**

Working with your team, brainstorm solutions related to performance and scale within a Well-Architected Framework.

For this topic, participants will analyze performance and scalability requirements within the workload architecture and evaluate how they contribute to and are affected by the overall fault tolerance of the workload.

**Resources**

**Characteristics of performance and scale**
Design efficiency [(design Azure applications for efficiency)](https://learn.microsoft.com/en-us/azure/architecture/framework/scalability/design-efficiency)
Scalability [(design for scaling)](https://learn.microsoft.com/en-us/azure/architecture/framework/scalability/design-scale)
Reactive
Proactive
Capacity [(plan for capacity)](https://learn.microsoft.com/en-us/azure/architecture/framework/scalability/design-capacity)
Testing [(performance testing)](https://learn.microsoft.com/en-us/azure/architecture/framework/scalability/performance-test#establish-baselines)
Baseline
Load
Stress
Chaos engineering [(chaos engineering)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/chaos-engineering)

Participant guidance

1. Brainstorm and analyze with your team the performance and scalability requirements within the workload architecture.
2. Evaluate how they contribute to or are affected by the overall fault tolerance of the workload.
3. Focusing on factors related to performance and scale, share all ideas that come to mind for how the customer's current PaaS or IaaS architecture could be made more efficient.
4. To guide your discussion, consider the provided resources and the following performance and scale questions:
   * What are the key performance requirements and metrics for the workload architecture?
   * What kind of testing is being done to measure performance (load, stress, chaos)?
   * What kind of testing is being done to measure fault tolerance (chaos)?
   * What are the key scaling points within the architecture?
   * What are the scaling requirements for these points (auto or reactive, proactive)?

Duration: 15 minutes

**Participant steps**

1. Work in the "Performance and Scale" topic column.
2. Answer the performance and scale questions using the information included in the customer scenario and your own experiences.
3. Complete the performance and scale-related fields in the whiteboard.
4. Go to the next activity to continue with the Well-Architected Framework analysis.

**Tips**

To help you answer the questions, consider the following characteristics that determine an architecture's performance and scale. These include:
* Design efficiency
* Scalability
* Performance testing
Refer to the resources section for more information about these topics.

**Summary**

This topic focused on solutions related to performance and scale. Next, you'll focus on security, governance, and identity.

---

### Part 3: Brainstorm solutions related to security, governance, and identity within a Well-Architected Framework

**Overview**

Working with your team, brainstorm solutions related to security, governance, and identity within a Well-Architected Framework.

For this topic, analyze with your team how security, governance, and identity requirements are being addressed by the workload architecture and operational strategies.

**Resources**

**Characteristics of security, governance, and identity**
* Auditability [(auditing)](https://learn.microsoft.com/en-us/azure/architecture/framework/devops/auditing)
* Governance [(governance, risk, and compliance)](https://learn.microsoft.com/en-us/azure/architecture/framework/security/design-governance)
  * Compliance
  * Privacy
  * Certifications
  * Data sovereignty
* Identity and access management [(identity and access management checklist)](https://learn.microsoft.com/en-us/azure/architecture/framework/security/design-identity)
* Data protection [(data protection in Azure)](https://learn.microsoft.com/en-us/azure/architecture/framework/security/design-storage)

**Participant guidance**

1. Analyze with your team how security, governance, and identity requirements are being addressed by the workload architecture and operational strategies.
2. Focusing on factors related to security, governance, and identity, share all ideas that come to mind for how the customer's current PaaS or IaaS architecture could be made more efficient.
3. To guide your discussion, consider the provided resources and the following security, governance, and identity questions:
   * What are the functional and nonfunctional requirements for security relative to the workload, and how does the architecture align with those requirements:
     * Data sovereignty and egress?  
     * Industry regulation and compliance?
     * Geopolitical?
   * What are the functional and nonfunctional requirements for identity (internal and external) relative to the workload, and how does the architecture align with those requirements?
   * What governance policies are in place that would affect the design and security of the workload architecture?

**Duration**: 15 minutes

**Participant Steps**

1. Work in the "Security, Governance, and Identity " topic column.
2. Answer the security, governance, and identity questions using the information included in the customer scenario and your own experiences.
3. Complete the security, governance, and identity-related fields in the whiteboard.
4. Go to the next activity to continue with the Well-Architected Framework analysis.

**Tips**

To help you answer the questions, consider the following characteristics that relate to security, governance, and identity. These include:
* Auditability
* Governance
* Identity and access management
* Data protection
Refer to the resources section for more information about these topics.

**Summary**

This topic focused on solutions related to security, governance, and identity. Next, you'll focus on DevOps.

---

### Part 4: Brainstorm solutions related to DevOps within a Well-Architected Framework

**Overview**

Working with your team, brainstorm solutions related to DevOps within a Well-Architected Framework. For this topic, analyze the automation and deployment strategies for the workload.

**Resources**

**Characteristics of DevOps**
* Automation [(automation overview of goals, best practices, and types in Azure)](https://learn.microsoft.com/en-us/azure/architecture/framework/devops/automation-overview)
  * Repeatable infrastructure [(repeatable infrastructure)](https://learn.microsoft.com/en-us/azure/architecture/framework/devops/automation-infrastructure)
* Configuration management [(external configuration store pattern)](https://learn.microsoft.com/en-us/azure/architecture/patterns/external-configuration-store)
* Release engineering [(release engineering continuous deployment)](https://learn.microsoft.com/en-us/azure/architecture/framework/devops/release-engineering-cd)
* Secrets management [(key and secret management in Azure)](https://learn.microsoft.com/en-us/azure/architecture/framework/security/design-storage-keys)

Participant guidance

1. Analyze with your team the automation and deployment strategies for the workload.
2. Focusing on factors related to DevOps, share all ideas that come to mind for how the customer's current PaaS or IaaS architecture could be made more efficient.
3. To guide your discussion, consider the provided resources and the following DevOps questions:
   * How is the infrastructure for the workload being deployed (infrastructure as code)?  
   * Do the deployment pipelines support multiple environments with production/nonproduction?  
   * How is the code for the workload being deployed (ADO)?  
   * Do these pipelines include automated tests, code scanning, and/or security scanning?
   * Are there any approval gates within the pipelines?

**Duration**: 15 minutes

**Participant steps**

1. Work in the "DevOps" topic column.
2. Answer the DevOps questions using the information included in the customer scenario and your own experiences.
3. Complete the DevOps-related fields in the whiteboard.
4. Go to the next activity to continue with the Well-Architected Framework analysis.

**Tips**

To help you answer the questions, consider the following characteristics that relate to an architecture's DevOps. These include:
* Automation
* Configuration management
* Release engineering
* Secrets management
Refer to the resources section for more information about these topics.

Summary
This topic focused on solutions related to DevOps. Next, you'll focus on observability.

---

### Part 5: Brainstorm solutions related to observability within a Well-Architected Framework

**Overview**

Working with your team, brainstorm solutions related to observability within a Well-Architected Framework. For this topic, you will analyze how observability requirements are being addressed by the workload architecture and operational strategies.

**Resources**

**Characteristics of observability**
* Monitoring [(monitoring for reliability)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/monitor-checklist)
  * Application [(monitor application health for reliability)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/monitoring)
  * Infrastructure [(infrastructure metrics and logs)](https://learn.microsoft.com/en-us/azure/architecture/framework/scalability/monitor-infrastructure)
  * Security [(security monitoring in Azure)](https://learn.microsoft.com/en-us/azure/architecture/framework/security/monitor)
* Alerting [(alerting for operations)](https://learn.microsoft.com/en-us/azure/architecture/framework/devops/monitor-alerts)
* Health modeling [(health modeling for reliability)](https://learn.microsoft.com/en-us/azure/architecture/framework/resiliency/monitor-model)
* Logging [(collect, aggregate, and store monitoring data for cloud applications)](https://learn.microsoft.com/en-us/azure/architecture/framework/devops/monitor-collection-data-storage)
* L1 / L2 / L3 support
  * Automated incident response [(health modeling and observability of mission-critical workloads on Azure)](https://learn.microsoft.com/en-us/azure/architecture/framework/mission-critical/mission-critical-health-modeling#automated-incident-response)

**Participant guidance**

1. Analyze with your team how observability requirements are being addressed by the workload architecture and operational strategies.
2. Focusing on factors related to observability, share all ideas that come to mind for how the customer's current IaaS or PaaS architecture could be made more efficient.
3. To guide your discussion, consider the provided resources and the following observability-related questions:
   * What are the functional and nonfunctional requirements for observability relative to the workload?
   * How does the architecture align with these requirements?
   * What is the key telemetry that needs to be captured and utilized?
   * What tools will be leveraged for capturing, monitoring, and alerting on the telemetry?
   * Are there any external dependencies that require access to this telemetry?

**Duration**: 15 minutes

**Participant steps**

1. Work in the "Observability" topic column.
2. Answer the observability questions using the information included in the customer scenario and your own experiences.
3. Complete the observability-related fields in the whiteboard.
4. Go to the next activity to continue with the Well-Architected Framework analysis.

**Tips**

To help you answer the questions, consider the following characteristics that determine an architecture's observability. These include:
* Monitoring
* Alerting
* Health modeling
* Logging
* L1 / L2 / L3 support
Refer to the resources section for more information about these topics.

**Summary**

This topic focused on solutions related to observability. Next, you'll wrap up the analysis phase with a discussion on the themes that emerged during your whiteboarding session.
