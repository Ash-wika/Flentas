# AWS Billing & Free Tier Cost Monitoring

This task is focused on setting up billing protection on the AWS account to avoid unexpected charges. I configured a CloudWatch billing alarm and enabled Free Tier usage alerts so the account immediately notifies me when spending crosses the safe threshold. This ensures everything stays within the Free Tier while testing or deploying infrastructure.

## Why Cost Monitoring Matters (Short Explanation)

Cost monitoring is essential, especially for beginners, because AWS has multiple services that can silently add charges if not managed. Services like NAT Gateways, EC2, RDS, EIPs, or any resource left running can increase monthly bills quickly. Setting alerts helps track usage in real time and prevents surprises at the end of the month.

## What Typically Causes Sudden AWS Bill Spikes

Some common reasons include:

Forgetting to delete NAT Gateways or EIPs

Running EC2/RDS instances 24×7

High S3 requests or data transfer

Leaving Auto Scaling Groups active

Misconfiguring CloudWatch logs or alarms

Keeping resources in multiple regions accidentally

Billing alerts help catch these issues instantly.

## What I Configured

✔ CloudWatch Billing Alarm at ₹100 threshold
✔ Email notification via SNS
✔ Enabled AWS Free Tier Usage Alerts
✔ Verified that billing alerts are active for the root user (required by AWS)

## Screenshots Included

I added the required screenshots inside the screenshots:
<img width="1918" height="721" alt="image" src="https://github.com/user-attachments/assets/392de316-2e12-4c9e-81f4-5234cbddce09" />
<img width="1919" height="497" alt="image" src="https://github.com/user-attachments/assets/00fa6643-5bea-4d5b-a8e6-e5043b738ebf" />




## Deployment Notes

No Terraform is recommended here because billing alarms are tied to the root account. I created the alarm manually using:

CloudWatch → Alarms → Billing → Create Alarm

Alert threshold set at ₹100

SNS topic for email notification

Free Tier alerts were enabled through:

Billing Console → Free Tier → "Activate Alerts"
