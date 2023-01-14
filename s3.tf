resource "aws_s3_bucket" "s3bucket" {
  bucket = "${var.env_name}${var.s3-bucket-name}"

  acl    = "private"
  
  versioning {
    enabled = true
  }
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = local.common_tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }   
}

