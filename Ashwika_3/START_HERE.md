# 🚀 START HERE - High Availability Architecture

Welcome to **Task 3: High Availability + Auto Scaling**!

---

## 🎯 What You're Building

A **production-grade, highly available** resume website with:
- ✨ Application Load Balancer
- ⚡ Auto Scaling (2-4 instances)
- 🌍 Multi-AZ deployment
- 🔒 Private subnets for security
- 📊 CloudWatch monitoring

---

## ⚡ Quick Deploy (10 Minutes)

### 1. Navigate to Task3
```powershell
cd e:\projects\Flentas\Task3
```

### 2. Initialize
```powershell
terraform init
```

### 3. Deploy
```powershell
terraform apply
```

Type `yes` when prompted.

### 4. Get Website URL
```powershell
terraform output website_url
```

### 5. Access Website
**Wait 5 minutes**, then open the URL!

---

## 📊 What Gets Created

| Resource | Count | Purpose |
|----------|-------|---------|
| VPC | 1 | Network isolation |
| Subnets | 4 | 2 public, 2 private |
| NAT Gateways | 2 | Internet access for private subnets |
| Load Balancer | 1 | Distribute traffic |
| EC2 Instances | 2-4 | Auto-scaled web servers |
| Security Groups | 2 | Network security |

**Total**: ~24 resources

---

## 💰 Cost

- **Monthly**: ~$80-100
- **Main costs**: NAT Gateways ($64), ALB ($16), EC2 ($17)

---

## 🎨 Features

- 🌍 **Multi-AZ**: Deployed across 2 Availability Zones
- ⚡ **Auto-Scaling**: Scales from 2 to 4 instances
- 🔒 **Secure**: Private subnets, encrypted storage
- 📊 **Monitored**: CloudWatch metrics
- 🚀 **Fast**: Load balanced

---

## 🧹 Cleanup

```powershell
terraform destroy
```

Type `yes` when prompted.

---

## 📚 Documentation

- **QUICKSTART.md** - Fast deployment guide
- **README.md** - Complete documentation
- **ARCHITECTURE.md** - Architecture diagrams
- **task.md** - Task summary

---

## 🆘 Troubleshooting

**Website not loading?**
- Wait 5 minutes for instances to launch
- Check: `terraform output website_url`
- Verify: Target health in AWS Console

**Costs too high?**
- Reduce NAT Gateways to 1
- Set ASG min/desired to 1

---

## 🎓 What You'll Learn

✅ VPC design with public/private subnets  
✅ Application Load Balancer setup  
✅ Auto Scaling Group configuration  
✅ Multi-AZ high availability  
✅ Production-grade AWS architecture  

---

## 🎯 Ready?

Run these commands:

```powershell
cd e:\projects\Flentas\Task3
terraform init
terraform apply
```

Then wait 5 minutes and access your highly available website! 🎉

---

**Need help?** Check `README.md` for detailed instructions!
