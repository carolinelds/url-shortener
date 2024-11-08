output "waf_acl_id" {
  description = "WAF ACL ID."
  value       = aws_wafv2_web_acl.main[*].id
}