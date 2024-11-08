output "s3_arn" {
  description = "S3 bucket ARN."
  value       = aws_s3_bucket.this.arn
}

output "s3_id" {
  description = "S3 bucket id."
  value       = aws_s3_bucket.this.id
}
