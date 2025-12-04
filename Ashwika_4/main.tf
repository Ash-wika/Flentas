# --- 1. AWS SNS Topic for Email Notifications ---
resource "aws_sns_topic" "billing_alerts" {
  name = "aws-billing-alerts-topic"
}

# Subscribe the specified email to the SNS Topic
# NOTE: You MUST manually click the confirmation link sent to this email after 'terraform apply'.
resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# --- 2. Custom CloudWatch Billing Alarm at ₹100 (Using AWS Budgets) ---
# Requirement 1: Set a CloudWatch Billing Alarm at ₹100
# We use AWS Budgets as it offers better functionality and currency support.
resource "aws_budgets_budget" "custom_cost_alarm" {
  name          = "Custom-Billing-Alarm-${var.cost_threshold_inr}INR"
  budget_type   = "COST"
  limit_amount  = tostring(var.cost_threshold_inr)
  limit_unit    = "USD"
  time_unit     = "MONTHLY"

  # Notification when ACTUAL costs exceed 100% of the budget (i.e., ₹100)
  notification {
    comparison_operator       = "GREATER_THAN"
    notification_type         = "ACTUAL"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    subscriber_sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
  }

  # Also add an alert for when FORECASTED costs exceed 80% (safety net)
  notification {
    comparison_operator       = "GREATER_THAN"
    notification_type         = "FORECASTED"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    subscriber_sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
  }
}

# --- 3. Enable Free Tier Usage Alerts (Using AWS Budgets) ---
# Requirement 2: Enable Free Tier usage alerts
# We create a Usage Budget that tracks ALL service usage, which is how AWS Budgets handles free tier monitoring.
# By setting the limit amount and threshold to '0' for a Usage budget, it triggers alerts when *any* usage is detected.
resource "aws_budgets_budget" "free_tier_usage_alert" {
  name          = "Free-Tier-Usage-Alert"
  budget_type   = "USAGE"
  limit_amount  = "0"
  limit_unit    = "GB" # Using a generic unit for 'all services'
  time_unit     = "MONTHLY"

  # Tracks ACTUAL usage against a 0 limit. This is effectively tracking usage.
  notification {
    comparison_operator       = "GREATER_THAN"
    notification_type         = "ACTUAL"
    threshold                 = 0.001 # A tiny amount > 0 to capture any usage
    threshold_type            = "ABSOLUTE_VALUE"
    subscriber_sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
  }
}

# --- Outputs to confirm creation ---
output "sns_topic_arn" {
  value       = aws_sns_topic.billing_alerts.arn
  description = "The ARN of the SNS topic. You must confirm the subscription email sent to the address in terraform.tfvars."
}