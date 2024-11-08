resource "aws_wafv2_web_acl_association" "main" {
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}

resource "aws_wafv2_ip_set" "main" {
  name = "${var.name}-waf-access"

  description        = "WAF access"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.allowed_cidrs
}

resource "aws_wafv2_web_acl" "main" {
  name = var.name

  scope = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "${var.name}-allowed-cidrs"
    priority = 0

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.main.arn
      }
    }

    visibility_config {
      metric_name                = "${var.name}-allowed-cidrs"
      cloudwatch_metrics_enabled = var.enable_cloudwatch_metrics_visibility
      sampled_requests_enabled   = var.enable_sampled_requests_visibility
    }
  }

  dynamic "rule" {
    for_each = var.enable_rate_limiting ? toset(["rate-limiting"]) : toset([])

    content {
      name     = "${var.name}-rate-limit"
      priority = 1

      action {
        block {}
      }

      statement {
        rate_based_statement {
          limit              = 400
          aggregate_key_type = "IP"
        }
      }

      visibility_config {
        metric_name                = "${var.name}-rate-limit"
        cloudwatch_metrics_enabled = var.enable_cloudwatch_metrics_visibility
        sampled_requests_enabled   = var.enable_sampled_requests_visibility
      }
    }
  }

  dynamic "rule" {
    for_each = zipmap(range(length(var.additional_rule_groups)), var.additional_rule_groups)

    content {
      name     = "additional-rule-group-${rule.key}"
      priority = rule.key + 10

      override_action {
        none {}
      }

      statement {
        rule_group_reference_statement {
          arn = rule.value
        }
      }

      visibility_config {
        metric_name                = "additional-rule-group-${rule.key}"
        cloudwatch_metrics_enabled = var.enable_cloudwatch_metrics_visibility
        sampled_requests_enabled   = var.enable_sampled_requests_visibility
      }
    }
  }

  visibility_config {
    metric_name                = var.name
    cloudwatch_metrics_enabled = var.enable_cloudwatch_metrics_visibility
    sampled_requests_enabled   = var.enable_sampled_requests_visibility
  }
}