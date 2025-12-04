# Task 3: High Availability + Auto Scaling

## 🎯 Project Overview

Deploy a **highly available, auto-scaling** resume website architecture on AWS with:
- Application Load Balancer (ALB) in public subnets
- EC2 instances in private subnets across multiple Availability Zones
- Auto Scaling Group for automatic scaling based on demand
- NAT Gateways for private subnet internet access
- Production-grade security and networking

## ✅ Requirements Met

1. ✅ Create an Internet-facing Application Load Balancer (ALB)
2. ✅ Migrate EC2 instance setup to private subnets
3. ✅ Create Auto Scaling Group (ASG) for high availability across AZs
4. ✅ Attach ALB to ASG
5. ✅ Ensure proper routing (public → ALB → private EC2 instances)

## 🏗️ Architecture

```
Internet
    ↓
Application Load Balancer (Public Subnets)
    ↓
Auto Scaling Group (Private Subnets)
    ├── EC2 Instance (AZ-1)
    └── EC2 Instance (AZ-2)
    ↓
NAT Gateways → Internet Gateway
```

### Network Architecture

- **VPC**: 10.0.0.0/16
- **Public Subnets**: 10.0.0.0/24, 10.0.1.0/24 (for ALB)
- **Private Subnets**: 10.0.10.0/24, 10.0.11.0/24 (for EC2)
- **Availability Zones**: 2 AZs for high availability
- **NAT Gateways**: 2 (one per AZ)

## 📦 Resources Created

### Networking
- **1 VPC** with DNS support
- **2 Public Subnets** (for ALB)
- **2 Private Subnets** (for EC2 instances)
- **1 Internet Gateway**
- **2 NAT Gateways** (high availability)
- **2 Elastic IPs** (for NAT Gateways)
- **3 Route Tables** (1 public, 2 private)

### Compute
- **1 Launch Template** (for ASG)
- **1 Auto Scaling Group** (2-4 instances)
- **2 Auto Scaling Policies** (CPU and Request-based)

### Load Balancing
- **1 Application Load Balancer**
- **1 Target Group**
- **1 ALB Listener** (HTTP:80)

### Security
- **2 Security Groups** (ALB and EC2)
- **Encrypted EBS volumes**
- **IMDSv2 enforcement**

## 🚀 Quick Start

### Prerequisites
- AWS Account
- AWS CLI configured
- Terraform installed
- Your IP address

### Deployment Steps

1. **Navigate to Task3 directory:**
   ```powershell
   cd e:\projects\Flentas\Task3
   ```

2. **Initialize Terraform:**
   ```powershell
   terraform init
   ```

3. **Review the plan:**
   ```powershell
   terraform plan
   ```

4. **Deploy infrastructure:**
   ```powershell
   terraform apply
   ```

5. **Access your website:**
   - Copy the `website_url` from outputs
   - Wait 3-5 minutes for instances to launch
   - Open URL in browser

## 🔒 Security Features

### Network Security
- ✅ Private subnets for EC2 instances
- ✅ Public subnets only for ALB
- ✅ NAT Gateways for outbound internet access
- ✅ Security groups with least privilege

### Instance Security
- ✅ Encrypted EBS volumes
- ✅ IMDSv2 enforcement
- ✅ Detailed CloudWatch monitoring
- ✅ SSH access restricted to your IP

### ALB Security
- ✅ Security headers
- ✅ HTTP/2 enabled
- ✅ Cross-zone load balancing
- ✅ Health checks configured

## ⚡ Auto Scaling Configuration

### Scaling Policies

**CPU-based Scaling:**
- Target: 70% CPU utilization
- Scales up when CPU > 70%
- Scales down when CPU < 70%

**Request-based Scaling:**
- Target: 1000 requests per target
- Scales based on ALB request count

### ASG Settings
- **Minimum**: 2 instances
- **Maximum**: 4 instances
- **Desired**: 2 instances
- **Health Check**: ELB
- **Grace Period**: 300 seconds

## 📊 High Availability Features

1. **Multi-AZ Deployment**
   - Instances across 2 Availability Zones
   - Automatic failover

2. **Load Balancing**
   - Traffic distributed across instances
   - Health checks every 30 seconds
   - Automatic instance replacement

3. **Auto Scaling**
   - Automatic capacity adjustment
   - Self-healing (replaces unhealthy instances)
   - Predictable performance

4. **Redundant NAT Gateways**
   - One NAT Gateway per AZ
   - No single point of failure

## 💰 Cost Estimation

### With AWS Free Tier (First 12 Months)
```
ALB:                 ~$16/month (not free tier)
EC2 (2x t2.micro):   $0 (750 hours/month free)
NAT Gateway (2x):    ~$64/month (not free tier)
EBS (60GB total):    $0 (within 30GB free tier)
Data Transfer:       $0 (first 15GB free)
─────────────────────────────────────────────
TOTAL:               ~$80/month
```

### After Free Tier
```
ALB:                 ~$16/month
EC2 (2x t2.micro):   ~$17/month
NAT Gateway (2x):    ~$64/month
EBS (60GB):          ~$6/month
─────────────────────────────────────────────
TOTAL:               ~$103/month
```

**Note**: NAT Gateways are the most expensive component. For cost savings, you can use a single NAT Gateway.

## 🎨 Features

### Website Features
- ✨ Ashwika's professional resume
- 📱 Responsive design
- 🎨 Modern dark theme
- ⚡ Fast loading via ALB

### Infrastructure Features
- 🔄 Auto-scaling based on demand
- 🌍 Multi-AZ high availability
- 🔒 Production-grade security
- 📊 CloudWatch monitoring
- 🚀 Zero-downtime deployments

## 📝 Configuration Files

| File | Purpose |
|------|---------|
| `main.tf` | Main infrastructure configuration |
| `variables.tf` | Variable definitions |
| `outputs.tf` | Output values |
| `terraform.tfvars` | Configuration values |
| `user-data.sh` | Instance initialization script |
| `.gitignore` | Git ignore rules |

## 🔧 Customization

### Adjust Auto Scaling

Edit `terraform.tfvars`:
```hcl
asg_min_size         = 2  # Minimum instances
asg_max_size         = 6  # Maximum instances
asg_desired_capacity = 3  # Desired instances
```

### Change Instance Type

```hcl
instance_type = "t3.micro"  # Or t2.small, t3.small, etc.
```

### Modify VPC CIDR

```hcl
vpc_cidr = "172.16.0.0/16"
```

## 🧪 Testing

### Test Load Balancing
```bash
# Get ALB DNS
terraform output website_url

# Make multiple requests
for i in {1..10}; do curl -s $(terraform output -raw website_url) | grep -i "ashwika"; done
```

### Test Auto Scaling
```bash
# Stress test (requires stress tool on instances)
# This will trigger CPU-based scaling

# Monitor ASG
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names $(terraform output -raw asg_name)
```

### Check Health
```bash
# Check target health
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw target_group_arn)
```

## 🔍 Monitoring

### CloudWatch Metrics
- ALB request count
- Target response time
- Healthy/Unhealthy host count
- ASG metrics (min/max/desired/in-service)
- EC2 CPU utilization

### Health Checks
- **Path**: /
- **Interval**: 30 seconds
- **Timeout**: 5 seconds
- **Healthy threshold**: 2
- **Unhealthy threshold**: 2

## 🧹 Cleanup

To destroy all resources:

```powershell
terraform destroy
```

Type `yes` when prompted.

**Warning**: This will delete:
- All EC2 instances
- Load Balancer
- NAT Gateways
- VPC and all networking
- All associated resources

## 🚨 Troubleshooting

### Website not accessible

1. **Check ALB status:**
   ```bash
   aws elbv2 describe-load-balancers \
     --names ha-resume-alb
   ```

2. **Check target health:**
   ```bash
   aws elbv2 describe-target-health \
     --target-group-arn $(terraform output -raw target_group_arn)
   ```

3. **Wait for instances:**
   - Instances take 3-5 minutes to launch
   - Health checks take 1-2 minutes

### No instances in ASG

1. **Check ASG status:**
   ```bash
   aws autoscaling describe-auto-scaling-groups \
     --auto-scaling-group-names $(terraform output -raw asg_name)
   ```

2. **Check launch template:**
   - Verify AMI is available
   - Check security group rules
   - Review user-data script

### High costs

1. **Reduce NAT Gateways:**
   - Use single NAT Gateway (modify main.tf)
   - Or remove NAT Gateways if outbound internet not needed

2. **Reduce instance count:**
   ```hcl
   asg_min_size = 1
   asg_desired_capacity = 1
   ```

## 📚 Additional Resources

- [AWS Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/)
- [Application Load Balancer Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/)
- [VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 🎓 Learning Outcomes

By completing this task, you've learned:

1. ✅ VPC design with public/private subnets
2. ✅ NAT Gateway configuration
3. ✅ Application Load Balancer setup
4. ✅ Auto Scaling Group configuration
5. ✅ Launch Templates
6. ✅ Target Groups and health checks
7. ✅ Multi-AZ high availability
8. ✅ Auto-scaling policies
9. ✅ Security group design
10. ✅ Production-grade AWS architecture

## 🏆 Architecture Highlights

### What Makes This Production-Ready

1. **High Availability**: Multi-AZ deployment with automatic failover
2. **Scalability**: Auto-scaling based on demand
3. **Security**: Private subnets, encrypted storage, restricted access
4. **Reliability**: Health checks and automatic instance replacement
5. **Performance**: Load balancing and distributed traffic
6. **Monitoring**: CloudWatch metrics and alarms ready
7. **Cost-Optimized**: Right-sized instances with auto-scaling

## 📊 Comparison with Task 2

| Feature | Task 2 (Basic) | Task 3 (HA) |
|---------|---------------|-------------|
| Availability | Single AZ | Multi-AZ |
| Instances | 1 | 2-4 (auto-scaled) |
| Load Balancer | None | ALB |
| Subnets | Public | Public + Private |
| NAT Gateway | No | Yes (2x) |
| Auto Scaling | No | Yes |
| Cost/month | ~$9 | ~$80-103 |
| Downtime Risk | High | Low |
| Scalability | Manual | Automatic |

---

**Status**: ✅ Ready for Deployment

**Deployment Time**: 10-15 minutes

**Difficulty**: Advanced

**AWS Services**: VPC, EC2, ALB, ASG, NAT Gateway, CloudWatch
