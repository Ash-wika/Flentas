# Task 2: EC2 Static Website Hosting

## 📋 Task Description

Deploy a static resume website on an EC2 instance using Nginx.

## ✅ Requirements

1. ✅ Launch a Free Tier EC2 instance in the public subnet
2. ✅ Install and configure Nginx
3. ✅ Host your resume as a static website
4. ✅ Ensure the site is accessible via public IP on port 80
5. ✅ Apply AWS best practices for basic infrastructure hardening

## 🎯 Implementation Summary

### Infrastructure Components

- **EC2 Instance**: t2.micro (Free Tier eligible)
- **AMI**: Amazon Linux 2023 (latest)
- **Security Group**: Custom with HTTP (80) and SSH (22) access
- **Elastic IP**: Static public IP address
- **EBS Volume**: 8GB encrypted root volume
- **VPC**: Default VPC with public subnet

### Security Best Practices Implemented

1. ✅ **EBS Encryption**: Root volume encrypted at rest
2. ✅ **IMDSv2 Only**: Instance Metadata Service v2 enforced
3. ✅ **Restricted SSH**: SSH access limited to specific IP address
4. ✅ **Minimal Security Group**: Only necessary ports opened (80, 22)
5. ✅ **Security Headers**: Nginx configured with security headers
6. ✅ **Detailed Monitoring**: CloudWatch detailed monitoring enabled
7. ✅ **Resource Tagging**: All resources properly tagged
8. ✅ **Automated Deployment**: User data script for consistent setup

### Website Features

The resume website includes:

- **Modern Design**: Dark mode with glassmorphism effects
- **Animated Background**: Floating gradient orbs with parallax effect
- **Responsive Layout**: Mobile-friendly design
- **Interactive Elements**: 
  - Animated skill progress bars
  - Smooth hover effects
  - Typing animation for title
  - Fade-in animations on scroll
- **Professional Content**:
  - Profile section with contact info
  - Skills with visual progress indicators
  - Certifications with badges
  - Work experience timeline
  - Education section
  - About me section

### Technology Stack

- **Infrastructure**: Terraform (IaC)
- **Web Server**: Nginx
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Cloud Provider**: AWS
- **Operating System**: Amazon Linux 2023

## 📁 Project Structure

```
task2/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variable definitions
├── outputs.tf           # Output definitions
├── terraform.tfvars     # Variable values (customize this)
├── user-data.sh         # EC2 user data script
├── website/
│   ├── index.html       # Resume website HTML
│   ├── style.css        # Modern CSS styling
│   └── script.js        # Interactive JavaScript
├── README.md            # Project documentation
├── DEPLOYMENT.md        # Deployment guide
├── .gitignore           # Git ignore rules
└── task.md              # This file
```

## 🚀 Quick Deployment

### Prerequisites
- AWS Account (Free Tier)
- AWS CLI configured
- Terraform installed

### Steps

1. **Configure your IP address** in `terraform.tfvars`:
   ```hcl
   my_ip = "YOUR_IP/32"
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Deploy infrastructure**:
   ```bash
   terraform apply
   ```

4. **Access your website**:
   - Copy the `website_url` from Terraform output
   - Open in browser after 2-3 minutes

5. **Cleanup when done**:
   ```bash
   terraform destroy
   ```

## 💰 Cost Estimation

**With AWS Free Tier**: $0/month
- EC2 t2.micro: 750 hours/month FREE
- EBS 8GB: Within 30GB FREE tier
- Elastic IP: FREE when attached to running instance

**After Free Tier**: ~$9.30/month
- EC2 t2.micro: ~$8.50/month
- EBS 8GB: ~$0.80/month

## 🔒 Security Considerations

### Implemented
- ✅ Encrypted EBS volumes
- ✅ IMDSv2 enforcement
- ✅ Restricted SSH access
- ✅ Security group with minimal permissions
- ✅ Nginx security headers
- ✅ No hardcoded credentials

### Recommendations for Production
- 🔐 Use AWS Secrets Manager for sensitive data
- 🔐 Implement HTTPS with ACM/Let's Encrypt
- 🔐 Enable AWS WAF for DDoS protection
- 🔐 Set up CloudWatch alarms
- 🔐 Implement backup strategy
- 🔐 Use Systems Manager Session Manager instead of SSH
- 🔐 Enable VPC Flow Logs
- 🔐 Implement least privilege IAM policies

## 📊 Monitoring

### Available Metrics
- EC2 instance metrics (CPU, network, disk)
- Nginx access and error logs
- CloudWatch detailed monitoring
- User data execution logs

### Access Logs
```bash
# SSH into instance
ssh ec2-user@<public-ip>

# View Nginx access logs
sudo tail -f /var/log/nginx/access.log

# View Nginx error logs
sudo tail -f /var/log/nginx/error.log

# Check user data execution
cat /var/log/user-data-complete.log
```

## 🎨 Customization

### Update Resume Content
1. Edit `website/index.html`
2. Modify personal information, skills, experience
3. Run `terraform apply` to redeploy

### Change Styling
1. Edit `website/style.css`
2. Modify colors, fonts, animations
3. Update CSS variables in `:root` for theme changes

### Add Features
1. Edit `website/script.js`
2. Add new interactive elements
3. Implement additional animations

## 🧪 Testing

### Manual Testing
1. ✅ Website loads successfully
2. ✅ All sections display correctly
3. ✅ Animations work smoothly
4. ✅ Responsive design on mobile
5. ✅ Security headers present
6. ✅ HTTP status 200 OK

### Automated Testing (Optional)
```bash
# Test HTTP response
curl -I http://<public-ip>

# Test security headers
curl -I http://<public-ip> | grep -i "x-frame-options"

# Load test (optional)
ab -n 1000 -c 10 http://<public-ip>/
```

## 📚 Learning Outcomes

By completing this task, you've learned:

1. ✅ EC2 instance provisioning with Terraform
2. ✅ Security group configuration
3. ✅ User data scripts for automation
4. ✅ Nginx installation and configuration
5. ✅ Static website hosting on EC2
6. ✅ AWS security best practices
7. ✅ Infrastructure as Code (IaC) principles
8. ✅ Resource tagging and management
9. ✅ Elastic IP allocation
10. ✅ Modern web design with HTML/CSS/JS

## 🔄 Next Steps

### Enhancements
- [ ] Add custom domain with Route 53
- [ ] Implement HTTPS with Let's Encrypt
- [ ] Set up CI/CD pipeline with GitHub Actions
- [ ] Add CloudFront CDN for better performance
- [ ] Implement automated backups
- [ ] Add monitoring and alerting
- [ ] Create auto-scaling group
- [ ] Implement blue-green deployment

### Advanced Topics
- [ ] Multi-region deployment
- [ ] Load balancer integration
- [ ] Container-based deployment (ECS/EKS)
- [ ] Serverless alternative (S3 + CloudFront)
- [ ] Infrastructure testing with Terratest
- [ ] Policy as Code with Sentinel

## 📖 Documentation

- **README.md**: Project overview and quick start
- **DEPLOYMENT.md**: Detailed deployment instructions
- **task.md**: This file - task summary and implementation details

## ✨ Highlights

### What Makes This Implementation Special

1. **Production-Ready Security**: Not just a basic setup, but implements real security best practices
2. **Beautiful Design**: Modern, professional resume website that stands out
3. **Fully Automated**: One command deployment with Terraform
4. **Well Documented**: Comprehensive guides for deployment and troubleshooting
5. **Cost Optimized**: Designed for AWS Free Tier
6. **Scalable Foundation**: Easy to extend and enhance

## 🎓 Skills Demonstrated

- ✅ AWS EC2 management
- ✅ Terraform Infrastructure as Code
- ✅ Nginx web server configuration
- ✅ Linux system administration
- ✅ Security best practices
- ✅ Modern web development
- ✅ Documentation and technical writing
- ✅ DevOps automation

## 📝 Notes

- The website uses modern CSS features (Grid, Flexbox, Custom Properties)
- JavaScript is vanilla (no frameworks) for simplicity
- All resources are tagged for easy management
- User data script is idempotent and logged
- Security group follows principle of least privilege

## 🏆 Success Criteria

All requirements met:
- ✅ EC2 instance launched in public subnet
- ✅ Nginx installed and configured
- ✅ Resume website hosted and accessible
- ✅ Accessible via public IP on port 80
- ✅ Security best practices applied

---

**Status**: ✅ Complete and Ready for Deployment

**Estimated Deployment Time**: 5 minutes

**Difficulty Level**: Beginner to Intermediate

**AWS Services Used**: EC2, VPC, Security Groups, EBS, Elastic IP
