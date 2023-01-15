data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
data "aws_cloudfront_cache_policy" "CachingDisabled" {
  name = "Managed-CachingDisabled"
}

