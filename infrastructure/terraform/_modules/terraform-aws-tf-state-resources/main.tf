resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
  tags   = var.tags_s3

  lifecycle {
    prevent_destroy = true # prevent accidental deletions at all cost
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = var.s3_bucket_name

  versioning_configuration {
    status     = "Enabled"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = var.s3_bucket_name

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle {
    prevent_destroy = true
  }
}
