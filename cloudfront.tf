resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.s3_origin_id
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  
  origin {
    domain_name = aws_s3_bucket.s3bucket.bucket_regional_domain_name
    origin_id   = var.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  default_root_object = "index.html"
  wait_for_deployment = false
  comment = var.comment

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.s3_origin_id
  

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  
    viewer_protocol_policy = "allow-all"
    min_ttl                = 1800
    default_ttl            = 1800
    max_ttl                = 1800
  
}

  ordered_cache_behavior {
    path_pattern     = "*"
    allowed_methods  = var.cached_methods
    cache_policy_id = data.aws_cloudfront_cache_policy.CachingDisabled.id
    cached_methods   = var.cached_methods
    target_origin_id = var.s3_origin_id

    viewer_protocol_policy = "allow-all"

    
    }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CO"]
    }
  }

  tags = local.common_tags

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version = "TLSv1.1_2016"
  }
}