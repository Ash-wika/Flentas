# Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                           INTERNET                                   │
└────────────────────────────────┬────────────────────────────────────┘
                                 │
                                 │ HTTP (Port 80)
                                 │
                    ┌────────────▼────────────┐
                    │   Internet Gateway      │
                    │   (Default VPC)         │
                    └────────────┬────────────┘
                                 │
                                 │
                    ┌────────────▼────────────┐
                    │   Elastic IP            │
                    │   (Static Public IP)    │
                    └────────────┬────────────┘
                                 │
                                 │
                    ┌────────────▼────────────┐
                    │   Security Group        │
                    │   ┌──────────────────┐  │
                    │   │ Inbound Rules:   │  │
                    │   │ - HTTP: 80       │  │
                    │   │ - SSH: 22        │  │
                    │   └──────────────────┘  │
                    └────────────┬────────────┘
                                 │
                                 │
        ┌────────────────────────▼────────────────────────┐
        │         EC2 Instance (t2.micro)                 │
        │  ┌──────────────────────────────────────────┐   │
        │  │  Amazon Linux 2023                       │   │
        │  │  ┌────────────────────────────────────┐  │   │
        │  │  │  Nginx Web Server                  │  │   │
        │  │  │  ┌──────────────────────────────┐  │  │   │
        │  │  │  │  Static Resume Website       │  │  │   │
        │  │  │  │  - index.html                │  │  │   │
        │  │  │  │  - style.css                 │  │  │   │
        │  │  │  │  - script.js                 │  │  │   │
        │  │  │  └──────────────────────────────┘  │  │   │
        │  │  └────────────────────────────────────┘  │   │
        │  └──────────────────────────────────────────┘   │
        │                                                  │
        │  ┌──────────────────────────────────────────┐   │
        │  │  EBS Volume (8GB, Encrypted)             │   │
        │  └──────────────────────────────────────────┘   │
        │                                                  │
        │  Security Features:                              │
        │  ✓ IMDSv2 Enforced                              │
        │  ✓ Detailed Monitoring                          │
        │  ✓ Security Headers                             │
        └──────────────────────────────────────────────────┘
                                 │
                                 │
                    ┌────────────▼────────────┐
                    │   CloudWatch            │
                    │   (Monitoring & Logs)   │
                    └─────────────────────────┘
```

## Component Details

### 1. Internet Gateway
- **Purpose**: Enables communication between VPC and internet
- **Type**: Default VPC Internet Gateway
- **Configuration**: Automatically attached to default VPC

### 2. Elastic IP
- **Purpose**: Provides static public IP address
- **Type**: AWS Elastic IP
- **Benefits**: IP persists across instance stops/starts
- **Cost**: Free when attached to running instance

### 3. Security Group
- **Name**: resume-website-sg
- **Inbound Rules**:
  - HTTP (80): 0.0.0.0/0 (public access)
  - SSH (22): Your IP only (restricted)
- **Outbound Rules**: All traffic allowed
- **VPC**: Default VPC

### 4. EC2 Instance
- **Type**: t2.micro (Free Tier eligible)
- **AMI**: Amazon Linux 2023 (latest)
- **vCPUs**: 1
- **Memory**: 1 GiB
- **Network**: Enhanced networking
- **Monitoring**: Detailed CloudWatch monitoring enabled

### 5. EBS Volume
- **Size**: 8 GB
- **Type**: gp3 (General Purpose SSD)
- **Encryption**: Enabled (AWS managed key)
- **IOPS**: 3000 baseline
- **Throughput**: 125 MB/s baseline

### 6. Nginx Web Server
- **Version**: Latest from Amazon Linux repos
- **Port**: 80 (HTTP)
- **Document Root**: /usr/share/nginx/html
- **Configuration**: Custom with security headers
- **Auto-start**: Enabled via systemd

### 7. Static Website
- **Files**: index.html, style.css, script.js
- **Design**: Modern dark theme with glassmorphism
- **Features**: Animated, responsive, interactive
- **Content**: Professional resume

## Data Flow

```
User Request → Internet → Internet Gateway → Elastic IP → 
Security Group (Port 80) → EC2 Instance → Nginx → 
Static HTML/CSS/JS → Response → User Browser
```

## Security Layers

```
Layer 1: Security Group (Network ACL)
         ↓
Layer 2: Nginx Security Headers
         ↓
Layer 3: EBS Encryption
         ↓
Layer 4: IMDSv2 Enforcement
         ↓
Layer 5: Restricted SSH Access
```

## Deployment Flow

```
Developer → Terraform Configuration → AWS API →
Resource Creation → User Data Execution →
Nginx Installation → Website Deployment →
Service Start → Website Live
```

## Terraform Resource Graph

```
data.aws_vpc.default
         ↓
data.aws_subnets.public
         ↓
data.aws_ami.amazon_linux_2023
         ↓
aws_security_group.web_server_sg
         ↓
aws_instance.web_server
         ↓
aws_eip.web_server_eip
```

## Monitoring Flow

```
EC2 Instance Metrics → CloudWatch →
Alarms (if configured) → SNS → Email/SMS
```

## Cost Breakdown (After Free Tier)

```
┌─────────────────────┬──────────────┬──────────────┐
│ Resource            │ Monthly Cost │ Annual Cost  │
├─────────────────────┼──────────────┼──────────────┤
│ EC2 t2.micro        │ $8.50        │ $102.00      │
│ EBS 8GB gp3         │ $0.80        │ $9.60        │
│ Elastic IP          │ $0.00*       │ $0.00*       │
│ Data Transfer (15GB)│ $0.00**      │ $0.00**      │
├─────────────────────┼──────────────┼──────────────┤
│ TOTAL               │ $9.30        │ $111.60      │
└─────────────────────┴──────────────┴──────────────┘

* Free when attached to running instance
** First 15GB outbound free
```

## High Availability Enhancement (Optional)

```
                    ┌─────────────────┐
                    │  Route 53 DNS   │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  Load Balancer  │
                    └────┬──────┬─────┘
                         │      │
              ┌──────────┘      └──────────┐
              │                            │
    ┌─────────▼─────────┐      ┌──────────▼────────┐
    │  EC2 Instance 1   │      │  EC2 Instance 2   │
    │  (AZ-1)           │      │  (AZ-2)           │
    └───────────────────┘      └───────────────────┘
```

## Disaster Recovery

```
Primary Region (us-east-1)
         │
         │ (Backup/Snapshot)
         ↓
Secondary Region (us-west-2)
```

---

**Legend**:
- ┌─┐ : Component/Service
- │   : Connection/Flow
- ▼   : Direction of flow
- ✓   : Feature enabled
