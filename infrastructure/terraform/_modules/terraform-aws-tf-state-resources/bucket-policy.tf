resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json

  depends_on = [aws_s3_bucket_public_access_block.this]

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Deny"
    actions = [
      "s3:*"
    ]

    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    effect = "Deny"
    actions = [
      "s3:DeleteBucket"
    ]

    resources = [
      "${aws_s3_bucket.this.arn}"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "*",
      ]
    }
  }
}