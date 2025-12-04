# EC2 Static Website Hosting with Nginx

This project deploys a professional static resume website on an AWS EC2 instance using Nginx, implemented with Infrastructure as Code (Terraform).

## 🎯 Project Overview

**Objective**: Deploy a static resume website on an EC2 instance using Nginx with AWS best practices for infrastructure hardening.

### Requirements Met ✅

1. ✅ Launch a Free Tier EC2 instance (t2.micro) in the public subnet
2. ✅ Install and configure Nginx automatically via user data
3. ✅ Host a professional resume as a static website
4. ✅ Ensure the site is accessible via public IP on port 80
5. ✅ Apply AWS best practices for basic infrastructure hardening

## 🏗️ Architecture

```
Internet
    |
    v
Internet Gateway
    |
    v
Security Group (HTTP:80, SSH:22)
    |
    v
EC2 Instance (t2.micro)
    |
    v
Nginx Web Server
    |
    v
Static Resume Website
```

## 🔒 Security Best Practices Implemented

1. **Encrypted EBS Volume**: Root volume encrypted at rest
2. **IMDSv2 Only**: Metadata service v2 enforced for better security
3. **Restricted SSH Access**: SSH limited to specific IP address (configurable)
4. **Security Group**: Minimal ingress rules (HTTP:80, SSH:22)
5. **Security Headers**: Nginx configured with security headers (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
6. **Detailed Monitoring**: CloudWatch detailed monitoring enabled
7. **Elastic IP**: Static IP address for consistent access
8. **Resource Tagging**: All resources properly tagged for management

## 📁 Project Structure

```
task2/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variable definitions
├── outputs.tf           # Output definitions
├── terraform.tfvars     # Variable values (customize this)
├── user-data.sh         # EC2 user data script for Nginx setup
├── website/
│   ├── index.html       # Resume website HTML
│   ├── style.css        # Styling with modern design
│   └── script.js        # Interactive JavaScript
├── README.md            # This file
└── DEPLOYMENT.md        # Deployment instructions
```

## 🚀 Quick Start

### Prerequisites

- AWS Account with Free Tier eligibility
- AWS CLI configured with credentials
- Terraform installed (v1.0+)
- Your public IP address for SSH access

### Step 1: Configure Variables

Edit `terraform.tfvars` and set your IP address:

```hcl
my_ip = "YOUR_IP_ADDRESS/32"  # e.g., "203.0.113.25/32"
```

Find your IP: https://whatismyipaddress.com/

### Step 2: Initialize Terraform

```bash
cd task2
terraform init
```

### Step 3: Review the Plan

```bash
terraform plan
```

### Step 4: Deploy Infrastructure

```bash
terraform apply
```

Type `yes` when prompted.

### Step 5: Access Your Website

After deployment completes (2-3 minutes), Terraform will output:

```
website_url = "http://XX.XX.XX.XX"
```

Open this URL in your browser to view your resume website!

## 📊 Resources Created

- **EC2 Instance**: t2.micro (Free Tier eligible)
- **Security Group**: Custom security group with HTTP and SSH rules
- **Elastic IP**: Static public IP address
- **EBS Volume**: 8GB encrypted root volume

## 🎨 Website Features

The resume website includes:

- **Modern Design**: Dark mode with glassmorphism effects
- **Animated Background**: Floating gradient orbs
- **Interactive Elements**: Smooth hover effects and transitions
- **Responsive Layout**: Mobile-friendly design
- **Professional Content**: Complete resume structure
  - Profile section with contact information
  - Skills with animated progress bars
  - Certifications
  - Work experience timeline
  - Education
  - About section

## 🔧 Customization

### Update Resume Content

Edit `website/index.html` to customize:
- Name and title
- Contact information
- Skills and proficiency levels
- Work experience
- Education
- Certifications

### Modify Styling

Edit `website/style.css` to change:
- Color scheme (CSS variables in `:root`)
- Layout and spacing
- Animations and effects

### Add Interactivity

Edit `website/script.js` to add:
- Custom animations
- Interactive features
- Dynamic content

After making changes, redeploy:

```bash
terraform apply
```

## 📝 Nginx Configuration

The Nginx configuration includes:

- **Document Root**: `/usr/share/nginx/html`
- **Port**: 80 (HTTP)
- **Security Headers**: X-Frame-Options, X-Content-Type-Options, X-XSS-Protection
- **Error Pages**: Custom 404 and 50x error pages
- **Logging**: Access and error logs enabled

## 🧹 Cleanup

To destroy all resources and avoid charges:

```bash
terraform destroy
```

Type `yes` when prompted.

**Important**: This will permanently delete all resources!

## 💰 Cost Estimation

With AWS Free Tier:
- **EC2 t2.micro**: 750 hours/month FREE (first 12 months)
- **EBS Storage**: 30GB FREE (first 12 months)
- **Data Transfer**: 15GB outbound FREE (first 12 months)
- **Elastic IP**: FREE when attached to running instance

**Estimated Monthly Cost**: $0 (within Free Tier limits)

After Free Tier:
- EC2 t2.micro: ~$8.50/month
- EBS 8GB: ~$0.80/month
- **Total**: ~$9.30/month

## 🔍 Troubleshooting

### Website not accessible

1. Check security group rules:
   ```bash
   aws ec2 describe-security-groups --group-ids <security-group-id>
   ```

2. Verify Nginx is running:
   ```bash
   ssh ec2-user@<public-ip>
   sudo systemctl status nginx
   ```

3. Check user data execution:
   ```bash
   cat /var/log/user-data-complete.log
   ```

### SSH connection refused

1. Verify your IP in `terraform.tfvars` is correct
2. Check security group allows SSH from your IP
3. Ensure you're using the correct key pair

### Terraform errors

1. Verify AWS credentials:
   ```bash
   aws sts get-caller-identity
   ```

2. Check Terraform version:
   ```bash
   terraform version
   ```

3. Re-initialize if needed:
   ```bash
   terraform init -upgrade
   ```

## 📚 Additional Resources

- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Free Tier](https://aws.amazon.com/free/)

## 🎓 Learning Outcomes

By completing this project, you've learned:

1. ✅ EC2 instance provisioning with Terraform
2. ✅ Security group configuration
3. ✅ User data scripts for automation
4. ✅ Nginx installation and configuration
5. ✅ Static website hosting
6. ✅ AWS security best practices
7. ✅ Infrastructure as Code principles
8. ✅ Resource tagging and management

## 📄 License

This project is provided as-is for educational purposes.

## 👤 Author

Created as part of AWS DevOps learning journey.

---

**Note**: Remember to destroy resources when done to avoid unnecessary charges!
