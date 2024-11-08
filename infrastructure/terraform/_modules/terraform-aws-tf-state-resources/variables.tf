variable "s3_bucket_name" {
  description = "Name of the bucket."
}

variable "s3_bucket_acl" {
  description = "Private or log-delivery-write."
  default     = "private"
}

variable "tags_s3" {
  description = "Specific tags for S3 bucket."
  type        = map(string)
  default     = {}
}