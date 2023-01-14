data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "mybucket" {
  bucket = aws_s3_bucket.s3bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}




