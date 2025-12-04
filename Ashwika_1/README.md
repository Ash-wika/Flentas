## Overview

This task establishes a foundational AWS network environment following best-practice subnetting and routing principles. The architecture consists of a custom VPC, public/private subnets across two Availability Zones, an Internet Gateway for external connectivity, and a NAT Gateway to enable secure outbound access for private instances. All resources are provisioned via Infrastructure as Code (Terraform), ensuring reproducibility and clean lifecycle management.

## Architecture Design Approach (4–6 Lines)

I designed a fully isolated VPC using a /16 CIDR block to ensure future scalability. The subnets were carved into evenly distributed /24 ranges across two Availability Zones—two public subnets for internet-facing resources and two private subnets for backend workloads. The Internet Gateway enables inbound/outbound traffic for public subnets, while the NAT Gateway allows private instances to reach the internet securely for updates and package installations. Separate route tables guarantee controlled traffic flow and clear separation of responsibilities between public and private layers.

## CIDR Strategy & Rationale
Component	CIDR	Reason
VPC	10.0.0.0/16	Large enough block for future scaling (65k addresses)
Public Subnet 1	10.0.1.0/24	AZ-A public layer
Public Subnet 2	10.0.2.0/24	AZ-B public layer
Private Subnet 1	10.0.3.0/24	AZ-A backend/app tier
Private Subnet 2	10.0.4.0/24	AZ-B backend/app tier

I chose /24 blocks to keep subnet sizes clean, predictable, and compliant with AWS design recommendations for HA architectures.

## Required AWS Screenshots

Include the following screenshots in this folder:
### VPC List:
<img width="1919" height="443" alt="image" src="https://github.com/user-attachments/assets/0295341d-aae2-4dc9-b126-07cdea8ad59f" />

### Subnet List (all 4 subnets):
<img width="1919" height="448" alt="image" src="https://github.com/user-attachments/assets/06f7560c-ad16-4333-a695-02e85061e51b" />

### Route Tables:
<img width="1917" height="446" alt="image" src="https://github.com/user-attachments/assets/b6c75d1f-fc0f-4029-b826-cae30ab4b5cc" />

### Internet Gateway:
<img width="1917" height="329" alt="image" src="https://github.com/user-attachments/assets/56c091b3-825b-4ce9-934a-4bb203fd61a3" />

### NAT Gateway:
<img width="1919" height="355" alt="image" src="https://github.com/user-attachments/assets/77243cef-805d-474a-8e63-bcd76968e546" />


All Terraform files for this task are available in:
/task-1-vpc-setup/main.tf

This includes:

VPC

Subnets (2 public, 2 private)

Route tables + associations

Internet Gateway

NAT Gateway + EIP

## 🛠️ How to Deploy
terraform init
terraform apply -var="prefix=FirstName_Lastname" -var="aws_region=ap-south-1"


To delete everything after screenshots:

terraform destroy

## 🔗 GitHub Repository Link

(Add your repo link here after pushing the code.)

## 🧹 Cleanup Reminder

Ensure that all resources (especially NAT Gateway) are destroyed after submission to avoid unwanted billing.
