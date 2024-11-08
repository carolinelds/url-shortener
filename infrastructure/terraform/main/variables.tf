################################################################################
# General variables
################################################################################

variable "aws" {
  description = "AWS configuration."
  type = map(object({
    region          = string
    assume_role_arn = string
  }))
}

variable "env" {
  description = "Environment to deploy to."
  type        = string
}

variable "owner" {
  description = "Owner of the project."
  type        = string

  validation {
    condition     = can(regex("^[a-z]+$", var.owner))
    error_message = "The owner name must be a lowercase string with no spaces, numerical or special characters."
  }

  default = "carolinelds"
}

variable "project" {
  description = "Project that will be provisioned and managed with this IaC code."
  type        = string

  validation {
    condition     = can(regex("^[a-z]+$", var.project))
    error_message = "The project name must be a lowercase string with no spaces, numerical or special characters."
  }

  default = "shortly"
}

variable "iac_source" {
  description = "Source for Terraform code."
  type        = string
  default     = "github.com/carolinelds/url-shortener"
}

################################################################################
# Project specific variables
################################################################################

variable "vpcs" {
  description = "Configuration values for the VPCs."
  type = map(object({
    cidr                   = string
    subnet_newbits         = number
    enable_nat_gateway     = bool
    one_nat_gateway_per_az = bool
    single_nat_gateway     = bool
  }))
}

variable "azs" {
  description = "List of availability zones to provision subnets to."
  type        = list(string)
}

variable "domain_name" {
  description = "Domain name to which request an ACM certificate."
  type        = string
  default     = "carolinelds.com"
}

variable "waf_allowed_cidrs" {
  description = "List of whitelisted IPs to have access to the application."
  type        = list(string)
  default     = []
}

variable "waf_enable_rate_limiting" {
  description = "Whether to enable rate limiting rule in WAF or not."
  type        = bool
  default     = true
}