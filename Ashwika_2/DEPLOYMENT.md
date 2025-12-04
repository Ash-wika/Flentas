# Deployment Guide - EC2 Static Website Hosting

This guide provides detailed step-by-step instructions for deploying your static resume website on AWS EC2.

## 📋 Prerequisites Checklist

Before you begin, ensure you have:

- [ ] AWS Account (Free Tier eligible)
- [ ] AWS CLI installed and configured
- [ ] Terraform installed (version 1.0 or later)
- [ ] Your public IP address
- [ ] Basic understanding of AWS EC2 and Terraform

## 🔧 Setup Instructions

### 1. Install Required Tools

#### Install AWS CLI

**Windows (PowerShell):**
```powershell
# Download and run the AWS CLI MSI installer
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
```

**macOS:**
```bash
brew install awscli
```

**Linux:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Verify installation:
```bash
aws --version
```

#### Install Terraform

**Windows (PowerShell):**
```powershell
# Using Chocolatey
choco install terraform

# Or download from: https://www.terraform.io/downloads
```

**macOS:**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

**Linux:**
```bash
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

Verify installation:
```bash
terraform version
```

### 2. Configure AWS Credentials

#### Option A: Using AWS CLI Configure

```bash
aws configure
```

Enter your credentials:
```
AWS Access Key ID: YOUR_ACCESS_KEY
AWS Secret Access Key: YOUR_SECRET_KEY
Default region name: us-east-1
Default output format: json
```

#### Option B: Using Environment Variables

**Windows (PowerShell):**
```powershell
$env:AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
$env:AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
$env:AWS_DEFAULT_REGION="us-east-1"
```

**macOS/Linux:**
```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
export AWS_DEFAULT_REGION="us-east-1"
```

Verify credentials:
```bash
aws sts get-caller-identity
```

### 3. Get Your Public IP Address

Find your public IP address:
- Visit: https://whatismyipaddress.com/
- Or run: `curl ifconfig.me`

**Important**: You'll need this in CIDR notation (e.g., `203.0.113.25/32`)

### 4. Configure Terraform Variables

Edit `terraform.tfvars`:

```hcl
# AWS Region
aws_region = "us-east-1"

# EC2 Instance Type (Free Tier eligible)
instance_type = "t2.micro"

# Your IP address for SSH access
my_ip = "YOUR_IP_ADDRESS/32"  # Replace with your actual IP
```

**Security Note**: Setting `my_ip = "0.0.0.0/0"` allows SSH from anywhere. This is NOT recommended for production!

## 🚀 Deployment Steps

### Step 1: Navigate to Project Directory

```bash
cd e:\projects\Flentas\task2
```

### Step 2: Initialize Terraform

This downloads the AWS provider and prepares your workspace:

```bash
terraform init
```

Expected output:
```
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/aws v5.x.x...

Terraform has been successfully initialized!
```

### Step 3: Validate Configuration

Check for syntax errors:

```bash
terraform validate
```

Expected output:
```
Success! The configuration is valid.
```

### Step 4: Format Code (Optional)

Format Terraform files:

```bash
terraform fmt
```

### Step 5: Review Execution Plan

See what Terraform will create:

```bash
terraform plan
```

Review the output carefully. You should see:
- 1 EC2 instance to be created
- 1 Security group to be created
- 1 Elastic IP to be created
- Data sources for VPC, subnets, and AMI

### Step 6: Apply Configuration

Deploy the infrastructure:

```bash
terraform apply
```

Terraform will show the plan again and ask for confirmation:
```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 
```

Type `yes` and press Enter.

### Step 7: Wait for Deployment

Deployment typically takes 2-3 minutes. You'll see:
```
aws_security_group.web_server_sg: Creating...
aws_security_group.web_server_sg: Creation complete after 3s
aws_instance.web_server: Creating...
aws_instance.web_server: Still creating... [10s elapsed]
aws_instance.web_server: Still creating... [20s elapsed]
aws_instance.web_server: Creation complete after 25s
aws_eip.web_server_eip: Creating...
aws_eip.web_server_eip: Creation complete after 2s

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

instance_id = "i-0123456789abcdef0"
instance_public_ip = "54.123.45.67"
website_url = "http://54.123.45.67"
```

### Step 8: Access Your Website

1. Copy the `website_url` from the output
2. Wait 1-2 minutes for user data script to complete
3. Open the URL in your browser

**Note**: If the site doesn't load immediately, wait a few minutes for Nginx to install and start.

## ✅ Verification Steps

### 1. Check EC2 Instance Status

```bash
aws ec2 describe-instances --instance-ids $(terraform output -raw instance_id)
```

### 2. Verify Security Group

```bash
aws ec2 describe-security-groups --group-ids $(terraform output -raw security_group_id)
```

### 3. Test HTTP Access

```bash
curl -I $(terraform output -raw website_url)
```

Expected response:
```
HTTP/1.1 200 OK
Server: nginx
```

### 4. SSH into Instance (Optional)

**Note**: You'll need the EC2 key pair for this. If you didn't specify one, you can't SSH.

```bash
ssh ec2-user@$(terraform output -raw instance_public_ip)
```

Check Nginx status:
```bash
sudo systemctl status nginx
```

Check user data log:
```bash
cat /var/log/user-data-complete.log
```

## 🔄 Making Updates

### Update Website Content

1. Edit files in `website/` directory
2. Run `terraform apply` to redeploy

### Update Infrastructure

1. Modify Terraform files (`main.tf`, `variables.tf`, etc.)
2. Run `terraform plan` to preview changes
3. Run `terraform apply` to apply changes

## 🧹 Cleanup and Destruction

### View Current Resources

```bash
terraform show
```

### Plan Destruction

```bash
terraform plan -destroy
```

### Destroy All Resources

```bash
terraform destroy
```

Confirm by typing `yes` when prompted.

**Warning**: This permanently deletes all resources!

### Verify Cleanup

```bash
terraform show
```

Should show: `No state.`

## 📊 Monitoring and Logs

### View Terraform State

```bash
terraform state list
```

### View Specific Resource

```bash
terraform state show aws_instance.web_server
```

### CloudWatch Logs (via AWS Console)

1. Go to AWS Console → CloudWatch
2. Navigate to Logs → Log Groups
3. Look for EC2 instance logs

### Nginx Logs (via SSH)

```bash
# Access logs
sudo tail -f /var/log/nginx/access.log

# Error logs
sudo tail -f /var/log/nginx/error.log
```

## 🔧 Troubleshooting

### Issue: "Error: No valid credential sources found"

**Solution**: Configure AWS credentials
```bash
aws configure
```

### Issue: "Error: Insufficient IAM permissions"

**Solution**: Ensure your IAM user has these permissions:
- EC2 Full Access
- VPC Read Access

### Issue: Website shows "Connection refused"

**Possible causes**:
1. User data script still running (wait 2-3 minutes)
2. Security group not allowing HTTP traffic
3. Nginx failed to start

**Debug steps**:
```bash
# SSH into instance
ssh ec2-user@<public-ip>

# Check Nginx status
sudo systemctl status nginx

# Start Nginx if stopped
sudo systemctl start nginx

# Check user data logs
cat /var/log/cloud-init-output.log
```

### Issue: "Error: Instance type not available"

**Solution**: Change instance type in `terraform.tfvars`:
```hcl
instance_type = "t3.micro"  # Alternative Free Tier option
```

### Issue: SSH connection timeout

**Possible causes**:
1. Incorrect IP in `my_ip` variable
2. Security group not allowing SSH
3. Instance not fully started

**Solution**: 
1. Verify your current IP: `curl ifconfig.me`
2. Update `terraform.tfvars` with correct IP
3. Run `terraform apply` to update security group

## 📈 Next Steps

After successful deployment:

1. ✅ Customize the resume content
2. ✅ Add your own styling
3. ✅ Set up a custom domain (Route 53)
4. ✅ Add HTTPS with Let's Encrypt
5. ✅ Implement CI/CD pipeline
6. ✅ Add monitoring and alerting

## 🎯 Best Practices

1. **Always review** `terraform plan` before applying
2. **Use version control** for your Terraform code
3. **Tag resources** appropriately (already implemented)
4. **Restrict SSH access** to your IP only
5. **Enable MFA** on your AWS account
6. **Use IAM roles** instead of access keys when possible
7. **Regularly update** AMIs and packages
8. **Monitor costs** in AWS Cost Explorer
9. **Set up billing alerts** to avoid surprises
10. **Document changes** in version control

## 📞 Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review Terraform error messages carefully
3. Check AWS CloudWatch logs
4. Verify AWS Free Tier limits
5. Consult AWS and Terraform documentation

## 🎓 Additional Learning

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/index.html)
- [Nginx Beginner's Guide](http://nginx.org/en/docs/beginners_guide.html)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

---

**Happy Deploying! 🚀**
