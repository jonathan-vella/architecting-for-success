# Architecting for Success - Whiteboard Design Session student guide

**Contents**

<!-- TOC -->

- [Enterprise Kubernetes Regulated Cluster whiteboard design session student guide](#\insert-workshop-name-here\-whiteboard-design-session-student-guide)
  - [Step 1: Review the customer case study](#step-1-review-the-customer-case-study) (15 mins)
    - [Case Study](./CaseStudy.md)
  - [Step 2: Design a proof of concept solution](#step-2-design-a-proof-of-concept-solution) (45 mins)
  - [Step 3: Present the solution](#step-3-present-the-solution)  (15 mins)
  - [Wrap-up](#wrap-up) (Optional 15 mins)  

<!-- /TOC -->

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