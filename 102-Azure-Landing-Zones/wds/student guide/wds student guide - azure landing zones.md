# Architecting for Success

# Azure Landing Zones Whiteboard Design Session

## Abstract and learning objectives

In this whiteboard design session, you will learn to design an Azure Landing Zones architecture for Contoso. You will be working through the customer scenario and their particular requirements to produce a tailored architecture for their Azure Landing Zone deployment.

---

## Step 1: Review the customer case study

**Outcome** Analyze your customer's needs.

Timeframe: 15 minutes

Directions: With all participants in the session, the facilitator/SME presents an overview of the customer case study along with technical tips.

1. Meet your team members and trainer.

2. Read all directions for steps 1-3 in the student guide.

3. As a team, review the customer case study.

### Infographic for common scenarios

**Azure Landing Zones conceptual architecture**
![For many organizations, the ALZ conceptual architecture below represents the destination in their cloud adoption journey. It's a mature, scaled-out target architecture intended to help organizations operate successful cloud environments that drive their business while maintaining best practices for security and governance.](/102-Azure-Landing-Zones/images/alz_accelerator.png)

---

## Step 2: Design a proof of concept solution

**Outcome**
Design a solution and prepare to present the solution to the target customer audience in a 10-minute chalk-talk format.

Timeframe: 30 minutes

Your design must include all of the following:

1. Details about minimum requirements and information you need have at hand to deploy ALZ accelerator. Think of tenants, subscriptions, privileged identities, security contacts, IP addresses, etc.
2. A management group hierarchy including subscription organization
3. A list of the required Azure Policy (built-in & custom) policies or initiatives including scope assignments
4. A list of RBAC assignment
5. A network topology


When designing your solution, consider the following:

1. What will you use to help the customer easily create cost-related reports for each workload based on department, owner, and environment? And how will you apply it?
2. How will you implement the customer's regulatory & compliance requirements?
3. How are you going to make sure that M-Series and L-Series VMs can only be deployed in the SAP environments without impacting agility and scale?
4. How will you ensure that "development environments and associated VNETs are not able to communicate with production"?
5. How will you assign developers access to development environments at scale and with minimal administrative effort?

---

## Step 3: Present the solution

**Outcome**
Present a solution to the target customer audience in a 10-minute chalk-talk format.

Timeframe: 10 minutes

**Presentation**
Directions:

1. Pair with another team.

2. One group is the Microsoft team, the other is the customer.

3. The Microsoft team presents their proposed solution to the customer.

4. The customer is expected to make one objections.

5. The Microsoft team responds to the objection.

6. The customer team gives feedback to the Microsoft team.