# 📋 Deployment Checklist

Use this checklist to ensure a smooth deployment of your EC2 static website.

---

## ✅ Pre-Deployment Checklist

### 1. Prerequisites Verification

- [ ] **AWS Account Created**
  - Free Tier eligible account
  - Credit card added (required for AWS)
  - Account activated and verified

- [ ] **AWS CLI Installed**
  ```bash
  aws --version
  # Should show: aws-cli/2.x.x or higher
  ```

- [ ] **Terraform Installed**
  ```bash
  terraform version
  # Should show: Terraform v1.0.0 or higher
  ```

- [ ] **AWS Credentials Configured**
  ```bash
  aws sts get-caller-identity
  # Should show your AWS account details
  ```

### 2. Configuration Setup

- [ ] **Get Your Public IP**
  - Visit: https://whatismyipaddress.com/
  - Or run: `curl ifconfig.me`
  - Note it down: ___________________

- [ ] **Update terraform.tfvars**
  - Open `terraform.tfvars`
  - Replace `0.0.0.0/0` with `YOUR_IP/32`
  - Save the file

- [ ] **Review Configuration**
  - AWS Region: `us-east-1` (or your preferred region)
  - Instance Type: `t2.micro` (Free Tier)
  - All settings look correct

### 3. Customization (Optional)

- [ ] **Customize Resume Content**
  - Edit `website/index.html`
  - Update name, contact info, experience
  - Save changes

- [ ] **Customize Styling**
  - Edit `website/style.css`
  - Modify colors, fonts if desired
  - Save changes

- [ ] **Review All Files**
  - All Terraform files present
  - Website files complete
  - No syntax errors

---

## 🚀 Deployment Steps

### Step 1: Initialize Terraform

- [ ] **Navigate to Project Directory**
  ```bash
  cd e:\projects\Flentas\task2
  ```

- [ ] **Initialize Terraform**
  ```bash
  terraform init
  ```
  
- [ ] **Verify Initialization**
  - Should see: "Terraform has been successfully initialized!"
  - `.terraform` directory created
  - Lock file created

### Step 2: Validate Configuration

- [ ] **Validate Terraform Files**
  ```bash
  terraform validate
  ```
  
- [ ] **Check for Errors**
  - Should see: "Success! The configuration is valid."
  - No error messages

- [ ] **Format Code (Optional)**
  ```bash
  terraform fmt
  ```

### Step 3: Review Plan

- [ ] **Generate Execution Plan**
  ```bash
  terraform plan
  ```

- [ ] **Review Plan Output**
  - Should create: 3 resources
    - 1 Security Group
    - 1 EC2 Instance
    - 1 Elastic IP
  - No resources to destroy
  - No unexpected changes

- [ ] **Verify Resources**
  - EC2 instance type: t2.micro
  - AMI: Amazon Linux 2023
  - Security group rules correct
  - EBS encryption enabled

### Step 4: Apply Configuration

- [ ] **Deploy Infrastructure**
  ```bash
  terraform apply
  ```

- [ ] **Review Plan Again**
  - Terraform shows the plan
  - All resources look correct

- [ ] **Confirm Deployment**
  - Type: `yes`
  - Press Enter

- [ ] **Wait for Completion**
  - Deployment takes 2-3 minutes
  - Watch progress messages
  - No errors appear

### Step 5: Verify Deployment

- [ ] **Check Outputs**
  - `instance_id` displayed
  - `instance_public_ip` displayed
  - `website_url` displayed
  - Copy website URL: ___________________

- [ ] **Wait for User Data**
  - Wait 2-3 minutes for Nginx installation
  - User data script needs time to complete

---

## ✅ Post-Deployment Verification

### 1. Website Accessibility

- [ ] **Open Website URL**
  - Paste URL in browser
  - Website loads successfully
  - No connection errors

- [ ] **Test HTTP Response**
  ```bash
  curl -I $(terraform output -raw website_url)
  ```
  - Should return: HTTP/1.1 200 OK
  - Server: nginx

### 2. Visual Verification

- [ ] **Check Website Appearance**
  - Dark theme loads correctly
  - Gradient background visible
  - Profile section displays
  - All sections present

- [ ] **Test Interactivity**
  - Hover effects work
  - Animations smooth
  - Skill bars animate
  - No console errors

- [ ] **Test Responsiveness**
  - Resize browser window
  - Test on mobile device
  - Layout adjusts properly

### 3. Security Verification

- [ ] **Check Security Headers**
  ```bash
  curl -I $(terraform output -raw website_url) | grep -i "x-frame-options"
  ```
  - X-Frame-Options present
  - X-Content-Type-Options present
  - X-XSS-Protection present

- [ ] **Verify HTTPS Redirect (if configured)**
  - Not applicable for basic setup
  - Can be added later

### 4. AWS Console Verification

- [ ] **Check EC2 Instance**
  - Go to AWS Console → EC2
  - Instance is running
  - Status checks: 2/2 passed
  - Monitoring enabled

- [ ] **Check Security Group**
  - Security group exists
  - Inbound rules correct:
    - HTTP (80) from 0.0.0.0/0
    - SSH (22) from your IP
  - Outbound rules: All traffic

- [ ] **Check Elastic IP**
  - Elastic IP allocated
  - Associated with instance
  - Matches output IP

### 5. Monitoring Setup

- [ ] **Check CloudWatch Metrics**
  - Go to CloudWatch
  - Instance metrics visible
  - Detailed monitoring enabled

- [ ] **Set Up Billing Alert (Recommended)**
  - Go to Billing → Budgets
  - Create budget alert
  - Set threshold: $5-10

---

## 🧪 Testing Checklist

### Functional Testing

- [ ] **Homepage Loads**
  - URL accessible
  - Content displays
  - Images/icons load

- [ ] **All Sections Present**
  - Profile section
  - Skills section
  - Experience section
  - Education section
  - Certifications section

- [ ] **Interactive Elements**
  - Skill bars animate on scroll
  - Hover effects work
  - Links functional
  - Smooth scrolling works

### Performance Testing

- [ ] **Page Load Speed**
  - Loads in < 3 seconds
  - No significant delays
  - Resources load efficiently

- [ ] **Browser Compatibility**
  - Test in Chrome
  - Test in Firefox
  - Test in Safari (if available)
  - Test in Edge

### Mobile Testing

- [ ] **Mobile Responsiveness**
  - Layout adapts to mobile
  - Text readable
  - Buttons/links tappable
  - No horizontal scroll

---

## 📊 Monitoring Checklist

### Daily (First Week)

- [ ] **Check Website Availability**
  - Visit website URL
  - Verify it's accessible

- [ ] **Monitor AWS Costs**
  - Check AWS Billing Dashboard
  - Verify within Free Tier limits

### Weekly

- [ ] **Review CloudWatch Metrics**
  - CPU utilization
  - Network traffic
  - Disk usage

- [ ] **Check for Updates**
  - Security patches available
  - Nginx updates needed

### Monthly

- [ ] **Cost Review**
  - Total AWS costs
  - Free Tier usage
  - Forecast for next month

- [ ] **Security Review**
  - Security group rules still appropriate
  - No unauthorized access attempts
  - Logs review

---

## 🧹 Cleanup Checklist

### When You're Done Testing

- [ ] **Backup Important Data**
  - Save any customizations
  - Export configurations
  - Document changes made

- [ ] **Plan Destruction**
  ```bash
  terraform plan -destroy
  ```
  - Review what will be destroyed
  - Confirm it's safe to proceed

- [ ] **Destroy Resources**
  ```bash
  terraform destroy
  ```
  - Type: `yes`
  - Wait for completion

- [ ] **Verify Cleanup**
  - Check AWS Console
  - All resources terminated
  - No orphaned resources

- [ ] **Check Final Costs**
  - Review AWS billing
  - Verify no ongoing charges
  - Check for any remaining resources

---

## 🔧 Troubleshooting Checklist

### If Website Doesn't Load

- [ ] **Wait Longer**
  - User data can take 3-5 minutes
  - Be patient on first deployment

- [ ] **Check Security Group**
  ```bash
  aws ec2 describe-security-groups --group-ids $(terraform output -raw security_group_id)
  ```
  - HTTP (80) rule present
  - Source: 0.0.0.0/0

- [ ] **Check Instance Status**
  ```bash
  aws ec2 describe-instance-status --instance-ids $(terraform output -raw instance_id)
  ```
  - Instance running
  - Status checks passed

- [ ] **SSH and Check Nginx**
  ```bash
  ssh ec2-user@$(terraform output -raw instance_public_ip)
  sudo systemctl status nginx
  ```
  - Nginx active and running
  - No error messages

### If Terraform Fails

- [ ] **Check AWS Credentials**
  ```bash
  aws sts get-caller-identity
  ```
  - Credentials valid
  - Correct account

- [ ] **Check IAM Permissions**
  - User has EC2 permissions
  - User has VPC permissions
  - User can create security groups

- [ ] **Check Terraform Version**
  ```bash
  terraform version
  ```
  - Version 1.0 or higher
  - AWS provider compatible

- [ ] **Re-initialize**
  ```bash
  terraform init -upgrade
  ```

### If Costs Are High

- [ ] **Verify Instance Type**
  - Should be t2.micro
  - Free Tier eligible

- [ ] **Check Running Time**
  - Free Tier: 750 hours/month
  - Stop when not needed

- [ ] **Review All Resources**
  - No extra instances
  - No unattached EIPs
  - No large EBS volumes

---

## 📝 Documentation Checklist

### Before Sharing/Submitting

- [ ] **Update README**
  - Reflect any customizations
  - Add any new features
  - Update screenshots if added

- [ ] **Document Changes**
  - List modifications made
  - Explain why changes were needed
  - Update version info

- [ ] **Test Documentation**
  - Follow your own instructions
  - Verify all commands work
  - Check for typos

---

## 🎯 Success Criteria

### Deployment Successful If:

- ✅ Website accessible via public IP
- ✅ All sections display correctly
- ✅ Animations work smoothly
- ✅ Responsive on mobile
- ✅ HTTP returns 200 OK
- ✅ Security headers present
- ✅ Within Free Tier costs
- ✅ No errors in logs
- ✅ Terraform state clean
- ✅ All documentation complete

---

## 🎓 Learning Verification

### You've Successfully Learned:

- [ ] How to provision EC2 instances with Terraform
- [ ] How to configure security groups
- [ ] How to use user data for automation
- [ ] How to install and configure Nginx
- [ ] How to host static websites on EC2
- [ ] How to implement AWS security best practices
- [ ] How to manage infrastructure as code
- [ ] How to monitor and troubleshoot deployments

---

## 📞 Need Help?

### Resources to Check:

1. [ ] **DEPLOYMENT.md** - Detailed deployment guide
2. [ ] **QUICK_REFERENCE.md** - Command reference
3. [ ] **README.md** - Project overview
4. [ ] **ARCHITECTURE.md** - System design
5. [ ] **AWS Documentation** - Official AWS docs
6. [ ] **Terraform Documentation** - Official Terraform docs

---

## ✨ Final Checklist

- [ ] All pre-deployment steps completed
- [ ] Deployment successful
- [ ] Post-deployment verification passed
- [ ] Testing completed
- [ ] Monitoring set up
- [ ] Documentation updated
- [ ] Ready to show/share
- [ ] Cleanup plan in place

---

**🎉 Congratulations! If all items are checked, your deployment is complete!**

**Date Completed**: ___________________

**Deployment Time**: ___________________ minutes

**Notes**: 
_____________________________________________
_____________________________________________
_____________________________________________

---

**Next Steps**: 
- [ ] Customize the resume with your information
- [ ] Add custom domain (optional)
- [ ] Implement HTTPS (optional)
- [ ] Set up CI/CD (advanced)
- [ ] Share your success! 🚀
