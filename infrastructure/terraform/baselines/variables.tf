variable "aws" {
  description = "AWS configuration."
  type = map(object({
    region              = string
    allowed_account_ids = list(string)
    profile_name        = string
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
  default     = "tf-s3-backend-initializer"
}

variable "iac_source" {
  description = "Source for Terraform code."
  type        = string
  default     = "github.com/carolinelds/url-shortener"
}

variable "tf_roles_to_create" {
  description = "Configuration map with the available roles to create."
  type = object({
    state   = bool
    general = bool
  })
}