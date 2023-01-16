resource "aws_s3_bucket" "s3bucket" {
  bucket = "${var.env_name}${var.s3-bucket-name}"

  versioning {
    enabled = false
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

resource "aws_s3_bucket" "s3bucketlog" {
  bucket = "${var.env_name}${var.s3-bucket-name}-log"
    versioning {
    enabled = false
  }

  tags = local.common_tags
}


resource "aws_s3_bucket_logging" "s3log" {
  bucket = aws_s3_bucket.s3bucket.id

  target_bucket = aws_s3_bucket.s3bucketlog.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.s3bucketlog.id
  acl    = "private"
}