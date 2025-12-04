# Quick Reference Guide - EC2 Static Website

## 🚀 Quick Commands

### Initial Setup
```bash
# Navigate to project
cd e:\projects\Flentas\task2

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt
```

### Deployment
```bash
# Preview changes
terraform plan

# Deploy infrastructure
terraform apply

# Auto-approve (use with caution)
terraform apply -auto-approve
```

### Management
```bash
# View current state
terraform show

# List all resources
terraform state list

# View specific resource
terraform state show aws_instance.web_server

# View outputs
terraform output

# View specific output
terraform output website_url
```

### Updates
```bash
# Refresh state
terraform refresh

# Taint resource (force recreation)
terraform taint aws_instance.web_server

# Untaint resource
terraform untaint aws_instance.web_server
```

### Cleanup
```bash
# Preview destruction
terraform plan -destroy

# Destroy all resources
terraform destroy

# Destroy specific resource
terraform destroy -target=aws_instance.web_server
```

## 📝 Important Files

| File | Purpose |
|------|---------|
| `main.tf` | Main infrastructure configuration |
| `variables.tf` | Variable definitions |
| `outputs.tf` | Output definitions |
| `terraform.tfvars` | Variable values (customize this!) |
| `user-data.sh` | EC2 initialization script |
| `website/index.html` | Resume website content |
| `website/style.css` | Website styling |
| `website/script.js` | Website interactivity |

## 🔧 Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `aws_region` | `us-east-1` | AWS region for deployment |
| `instance_type` | `t2.micro` | EC2 instance type |
| `my_ip` | Required | Your IP for SSH access |

## 📊 Terraform Outputs

| Output | Description |
|--------|-------------|
| `instance_id` | EC2 instance ID |
| `instance_public_ip` | Public IP address |
| `instance_public_dns` | Public DNS name |
| `website_url` | Direct URL to website |
| `security_group_id` | Security group ID |
| `ami_id` | AMI ID used |

## 🔍 Troubleshooting Commands

### Check AWS Credentials
```bash
aws sts get-caller-identity
aws configure list
```

### Check EC2 Instance
```bash
# Get instance details
aws ec2 describe-instances --instance-ids $(terraform output -raw instance_id)

# Get instance status
aws ec2 describe-instance-status --instance-ids $(terraform output -raw instance_id)
```

### Check Security Group
```bash
aws ec2 describe-security-groups --group-ids $(terraform output -raw security_group_id)
```

### Test Website
```bash
# Test HTTP response
curl -I $(terraform output -raw website_url)

# Download homepage
curl $(terraform output -raw website_url)

# Test with verbose output
curl -v $(terraform output -raw website_url)
```

### SSH into Instance
```bash
# Connect to instance
ssh ec2-user@$(terraform output -raw instance_public_ip)

# Check Nginx status
sudo systemctl status nginx

# Restart Nginx
sudo systemctl restart nginx

# View Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Check user data execution
cat /var/log/user-data-complete.log
cat /var/log/cloud-init-output.log
```

## 🛡️ Security Checklist

- [ ] Updated `my_ip` in `terraform.tfvars` with your actual IP
- [ ] Reviewed security group rules
- [ ] Verified EBS encryption is enabled
- [ ] Confirmed IMDSv2 is enforced
- [ ] Checked that no sensitive data is in version control
- [ ] Reviewed Nginx security headers
- [ ] Enabled detailed monitoring
- [ ] Tagged all resources appropriately

## 💰 Cost Monitoring

### Check Current Costs
```bash
# Using AWS CLI
aws ce get-cost-and-usage \
  --time-period Start=2024-01-01,End=2024-01-31 \
  --granularity MONTHLY \
  --metrics BlendedCost
```

### Free Tier Usage
- EC2 t2.micro: 750 hours/month
- EBS: 30GB storage
- Data transfer: 15GB outbound

## 📋 Pre-Deployment Checklist

- [ ] AWS CLI installed and configured
- [ ] Terraform installed (v1.0+)
- [ ] AWS credentials configured
- [ ] Public IP address obtained
- [ ] `terraform.tfvars` updated with your IP
- [ ] Reviewed `main.tf` configuration
- [ ] Customized website content (optional)

## 📋 Post-Deployment Checklist

- [ ] Website accessible via public IP
- [ ] HTTP returns 200 OK
- [ ] All website sections display correctly
- [ ] Animations work smoothly
- [ ] Responsive design works on mobile
- [ ] Security headers present
- [ ] Nginx logs show no errors

## 🔄 Common Workflows

### Deploy New Website Version
```bash
# 1. Edit website files
# 2. Apply changes
terraform apply

# 3. Verify deployment
curl -I $(terraform output -raw website_url)
```

### Change Instance Type
```bash
# 1. Edit terraform.tfvars
instance_type = "t3.micro"

# 2. Apply changes
terraform apply

# Note: This will recreate the instance
```

### Update Security Group
```bash
# 1. Edit main.tf security group rules
# 2. Apply changes
terraform apply

# 3. Verify
aws ec2 describe-security-groups --group-ids $(terraform output -raw security_group_id)
```

## 🎯 Quick Tips

1. **Always run `terraform plan`** before `apply`
2. **Use version control** for your Terraform code
3. **Never commit** `terraform.tfvars` with sensitive data
4. **Tag your resources** for easy identification
5. **Set up billing alerts** to avoid surprises
6. **Destroy resources** when not in use to save costs
7. **Keep Terraform updated** to the latest version
8. **Use workspaces** for multiple environments
9. **Enable state locking** for team collaboration
10. **Document all changes** in commit messages

## 📞 Getting Help

### Terraform Help
```bash
terraform -help
terraform plan -help
terraform apply -help
```

### AWS CLI Help
```bash
aws help
aws ec2 help
aws ec2 describe-instances help
```

### Useful Links
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Nginx Documentation](https://nginx.org/en/docs/)

## 🎓 Learning Resources

- [Terraform Tutorials](https://learn.hashicorp.com/terraform)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [Nginx Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html)

---

**Quick Start**: `terraform init` → `terraform apply` → Access website URL

**Quick Cleanup**: `terraform destroy`
