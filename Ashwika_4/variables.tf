variable "alert_email" {
  description = "The email address to send billing alerts to."
  type        = string
}

variable "cost_threshold_inr" {
  description = "The cost threshold in INR (Indian Rupees) for the Custom Alarm."
  type        = number
  default     = 100
}