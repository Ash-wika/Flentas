# 🚀 Quick Start Guide - High Availability Architecture

## ⚡ 5-Minute Deployment

### Step 1: Navigate to Task3
```powershell
cd e:\projects\Flentas\Task3
```

### Step 2: Initialize Terraform
```powershell
terraform init
```

### Step 3: Deploy
```powershell
terraform apply -auto-approve
```

### Step 4: Get Website URL
```powershell
terraform output website_url
```

### Step 5: Access Website
Wait 5 minutes, then open the URL in your browser!

---

## 📋 What Gets Created

- ✅ **1 VPC** with public and private subnets
- ✅ **2 NAT Gateways** for high availability
- ✅ **1 Application Load Balancer**
- ✅ **2-4 EC2 Instances** (auto-scaled)
- ✅ **Complete networking** (IGW, Route Tables, etc.)

---

## 💰 Estimated Cost

**~$80-100/month** (mostly NAT Gateways)

---

## 🧹 Cleanup

```powershell
terraform destroy -auto-approve
```

---

## 🎯 Key Features

- 🌍 **Multi-AZ**: Deployed across 2 Availability Zones
- ⚡ **Auto-Scaling**: 2-4 instances based on load
- 🔒 **Secure**: Private subnets, encrypted storage
- 📊 **Monitored**: CloudWatch metrics enabled
- 🚀 **Fast**: Load balanced traffic

---

## 📞 Need Help?

Check `README.md` for detailed documentation!
