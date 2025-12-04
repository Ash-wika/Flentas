# Task 3: High Availability + Auto Scaling

## ✅ Task Summary

Successfully implemented a **production-grade, highly available** architecture with:

### Requirements Completed

1. ✅ **Internet-facing Application Load Balancer (ALB)**
   - Created in public subnets across 2 AZs
   - HTTP listener on port 80
   - Health checks configured
   - Cross-zone load balancing enabled

2. ✅ **EC2 Instances in Private Subnets**
   - Migrated from public to private subnets
   - No direct internet access
   - Outbound access via NAT Gateways
   - Enhanced security posture

3. ✅ **Auto Scaling Group (ASG)**
   - Min: 2, Max: 4, Desired: 2 instances
   - Deployed across 2 Availability Zones
   - Automatic instance replacement
   - Self-healing capabilities

4. ✅ **ALB Attached to ASG**
   - Target Group integration
   - Automatic instance registration
   - Health-based traffic routing
   - Seamless scaling

5. ✅ **Proper Routing**
   - Public → Internet Gateway → ALB
   - ALB → Private EC2 instances
   - Private → NAT Gateway → Internet
   - Fully functional traffic flow

---

## 🏗️ Infrastructure Created

### Networking (15 resources)
- 1 VPC (10.0.0.0/16)
- 2 Public Subnets
- 2 Private Subnets
- 1 Internet Gateway
- 2 NAT Gateways
- 2 Elastic IPs
- 3 Route Tables
- 4 Route Table Associations

### Compute & Scaling (4 resources)
- 1 Launch Template
- 1 Auto Scaling Group
- 2 Auto Scaling Policies
- 2-4 EC2 Instances (dynamic)

### Load Balancing (3 resources)
- 1 Application Load Balancer
- 1 Target Group
- 1 ALB Listener

### Security (2 resources)
- 1 ALB Security Group
- 1 EC2 Security Group

**Total: ~24+ resources**

---

## 🎯 Architecture Highlights

### High Availability
- ✅ Multi-AZ deployment (2 AZs)
- ✅ Redundant NAT Gateways
- ✅ Load balancer health checks
- ✅ Automatic failover

### Scalability
- ✅ Auto-scaling (2-4 instances)
- ✅ CPU-based scaling policy
- ✅ Request-based scaling policy
- ✅ Automatic capacity adjustment

### Security
- ✅ Private subnets for EC2
- ✅ Encrypted EBS volumes
- ✅ IMDSv2 enforcement
- ✅ Security groups with least privilege
- ✅ No direct internet access to instances

### Performance
- ✅ Load balanced traffic
- ✅ Cross-zone load balancing
- ✅ HTTP/2 enabled
- ✅ Optimized routing

---

## 📊 Comparison: Task 2 vs Task 3

| Feature | Task 2 | Task 3 |
|---------|--------|--------|
| **Architecture** | Single instance | Multi-instance HA |
| **Availability Zones** | 1 | 2 |
| **Instances** | 1 fixed | 2-4 auto-scaled |
| **Load Balancer** | ❌ None | ✅ ALB |
| **Subnet Type** | Public | Private |
| **NAT Gateway** | ❌ No | ✅ Yes (2x) |
| **Auto Scaling** | ❌ No | ✅ Yes |
| **Failover** | ❌ Manual | ✅ Automatic |
| **Cost/month** | ~$9 | ~$80-103 |
| **Downtime Risk** | High | Very Low |
| **Production Ready** | No | Yes |

---

## 💰 Cost Breakdown

### Monthly Costs (After Free Tier)

| Resource | Quantity | Cost/Month |
|----------|----------|------------|
| ALB | 1 | ~$16 |
| EC2 t2.micro | 2 | ~$17 |
| NAT Gateway | 2 | ~$64 |
| EBS (30GB each) | 2 | ~$6 |
| Data Transfer | Varies | ~$0-5 |
| **TOTAL** | - | **~$103** |

### Cost Optimization Tips

1. **Reduce NAT Gateways**: Use 1 instead of 2 (-$32/month)
2. **Reduce Instances**: Set min=1, desired=1 (-$8.50/month)
3. **Use Reserved Instances**: Save up to 40% on EC2
4. **Monitor Data Transfer**: Optimize to stay in free tier

---

## 🚀 Deployment Guide

### Prerequisites
- AWS Account
- AWS CLI configured
- Terraform installed
- Your IP address (already set: 103.46.203.222/32)

### Quick Deploy
```powershell
cd e:\projects\Flentas\Task3
terraform init
terraform apply -auto-approve
```

### Access Website
```powershell
# Get URL
terraform output website_url

# Wait 5 minutes for instances to launch
# Then open URL in browser
```

---

## 🔧 Configuration

### Auto Scaling Settings
```hcl
asg_min_size         = 2  # Minimum instances
asg_max_size         = 4  # Maximum instances
asg_desired_capacity = 2  # Desired instances
```

### Scaling Policies
- **CPU Target**: 70% utilization
- **Request Target**: 1000 requests/target

### Health Checks
- **Interval**: 30 seconds
- **Timeout**: 5 seconds
- **Healthy Threshold**: 2 checks
- **Unhealthy Threshold**: 2 checks

---

## 📈 Monitoring

### CloudWatch Metrics Available
- ALB Request Count
- Target Response Time
- Healthy/Unhealthy Host Count
- ASG Instance Count
- EC2 CPU Utilization
- Network In/Out

### Health Check Monitoring
```bash
# Check target health
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw target_group_arn)
```

---

## 🧪 Testing

### Test Load Balancing
```bash
# Make multiple requests
for i in {1..20}; do
  curl -s $(terraform output -raw website_url) | grep "Ashwika"
done
```

### Test Auto Scaling
```bash
# Monitor ASG
watch -n 5 "aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names $(terraform output -raw asg_name) \
  --query 'AutoScalingGroups[0].[DesiredCapacity,MinSize,MaxSize]'"
```

---

## 🎓 Learning Outcomes

### Skills Demonstrated

1. ✅ **VPC Design**
   - Public/private subnet architecture
   - Multi-AZ deployment
   - NAT Gateway configuration

2. ✅ **Load Balancing**
   - ALB setup and configuration
   - Target group management
   - Health check configuration

3. ✅ **Auto Scaling**
   - Launch template creation
   - ASG configuration
   - Scaling policies (CPU and request-based)

4. ✅ **High Availability**
   - Multi-AZ redundancy
   - Automatic failover
   - Self-healing infrastructure

5. ✅ **Security**
   - Network segmentation
   - Security group design
   - Private subnet isolation

6. ✅ **Infrastructure as Code**
   - Advanced Terraform patterns
   - Resource dependencies
   - Output management

---

## 🔍 Troubleshooting

### Website Not Accessible

1. **Check ALB Status**
   ```bash
   aws elbv2 describe-load-balancers --names ha-resume-alb
   ```

2. **Check Target Health**
   ```bash
   aws elbv2 describe-target-health \
     --target-group-arn $(terraform output -raw target_group_arn)
   ```

3. **Wait for Instances**
   - Instances take 3-5 minutes to launch
   - Health checks take 1-2 minutes to pass

### No Instances in ASG

1. **Check ASG Activity**
   ```bash
   aws autoscaling describe-scaling-activities \
     --auto-scaling-group-name $(terraform output -raw asg_name) \
     --max-records 10
   ```

2. **Check Launch Template**
   - Verify AMI availability
   - Check security group rules
   - Review user-data script

---

## 🧹 Cleanup

### Destroy All Resources
```powershell
terraform destroy -auto-approve
```

This will delete:
- All EC2 instances
- Load Balancer and Target Group
- NAT Gateways and Elastic IPs
- VPC and all networking components
- Security Groups
- Launch Template and ASG

**Estimated time**: 5-10 minutes

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Complete documentation |
| `ARCHITECTURE.md` | Architecture diagrams |
| `QUICKSTART.md` | Quick deployment guide |
| `task.md` | This file - task summary |
| `main.tf` | Infrastructure code |
| `variables.tf` | Variable definitions |
| `outputs.tf` | Output values |

---

## 🏆 Success Criteria

All requirements met:
- ✅ Internet-facing ALB created
- ✅ EC2 instances in private subnets
- ✅ Auto Scaling Group configured
- ✅ ALB attached to ASG
- ✅ Proper routing established
- ✅ High availability achieved
- ✅ Auto-scaling functional
- ✅ Security best practices applied

---

## 🎯 Next Steps

### Enhancements
- [ ] Add HTTPS with ACM certificate
- [ ] Implement CloudFront CDN
- [ ] Add Route 53 custom domain
- [ ] Set up CloudWatch alarms
- [ ] Implement CI/CD pipeline
- [ ] Add WAF for DDoS protection
- [ ] Configure auto-scaling schedules
- [ ] Implement blue-green deployment

### Advanced Topics
- [ ] Multi-region deployment
- [ ] Database integration (RDS)
- [ ] ElastiCache for caching
- [ ] S3 for static assets
- [ ] Lambda@Edge for customization
- [ ] Container-based deployment (ECS/EKS)

---

**Status**: ✅ Complete and Production-Ready

**Deployment Time**: 10-15 minutes

**Difficulty**: Advanced

**Cost**: ~$80-103/month (after Free Tier)

**AWS Services Used**: VPC, EC2, ALB, ASG, NAT Gateway, CloudWatch, IAM

---

**🎉 Congratulations! You've built a production-grade, highly available architecture!** 🎉
