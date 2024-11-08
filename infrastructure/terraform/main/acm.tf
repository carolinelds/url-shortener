# For POC purposes, it has been created manually

# resource "aws_acm_certificate" "cert" {
#   count = var.dev ? 1 : 0 # create only once

#   domain_name       = var.domain_name
#   subject_alternative_names = [
#     "${var.project}.${var.domain_name}"
#     "www.${var.project}.${var.domain_name}"
#   ]
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }