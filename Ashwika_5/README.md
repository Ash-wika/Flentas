# 🖥️ Task 5 – AWS High-Scalability Architecture Diagram (draw.io)

This task focuses on designing a production-grade, scalable AWS architecture capable of handling 10,000+ concurrent users. The entire diagram is created using draw.io, and the exported PNG/PDF files are included in this folder.

## 1. High-Level Architecture Explanation (5–8 Lines)

The architecture is structured using a multi-tier VPC with segregated public and private subnets across two Availability Zones to ensure high availability. Incoming traffic is routed through an Internet-facing ALB, which distributes load to an Auto Scaling Group placed inside private subnets. The application layer interacts with a Multi-AZ RDS/Aurora database hosted in dedicated DB subnets. To improve performance under high concurrency, Redis (ElastiCache) is used for caching responses, sessions, and frequent lookups. Security is enforced using Security Groups, NACLs, IAM roles, and AWS WAF at the ALB layer. CloudWatch handles logging, monitoring, alarms, and operational insights across the stack.

## 2. Files Included in This Folder

architecture.drawio – editable source file

architecture.png – exported architecture diagram

architecture.pdf – high-quality export for submission

## 3. Core AWS Services Used
-⚡ Compute / Scaling: 

Application Load Balancer (Internet-Facing)

Auto Scaling Group (Multi-AZ)

EC2 Instances (Private Subnets)

-🗄️ Database Layer:

Amazon RDS / Aurora (Multi-AZ)

-⚡ Performance / Caching:

Amazon ElastiCache (Redis)

-🌐 Networking:

Public + Private Subnets

Route Tables

NAT Gateway

Internet Gateway

-🔐 Security:

Security Groups

NACLs

AWS WAF

IAM Roles / Policies

-📊 Observability:

CloudWatch Logs

CloudWatch Alarms

CloudWatch Metrics


Upload the exported PNG/PDF inside this folder.
