variable "resource_arn" {
  description = "ARN of the resource to be associated with the Web Application Firewall (WAF) Access Control List (ACL)."
  type        = string
  default     = ""
}

variable "allowed_cidrs" {
  description = "List of sets of IP addresses to allow."
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name of the Web ACL"
  type        = string
  default     = ""
}

variable "enable_cloudwatch_metrics_visibility" {
  description = "Enable WAF logging."
  type        = bool
  default     = true
}

variable "enable_sampled_requests_visibility" {
  description = "Enable WAF sampling."
  type        = bool
  default     = true
}

variable "enable_json_type_validator" {
  description = "Enable validator for body of type application/json."
  default     = true
}

variable "enable_rate_limiting" {
  description = "Enable rate limiting."
  default     = true
}

variable "additional_rule_groups" {
  type        = list(string)
  description = "List of rule groups ARNs to attach in this WAF."
  default     = []
}