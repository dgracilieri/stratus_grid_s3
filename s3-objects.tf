resource "aws_s3_bucket_object" "html" {
  for_each = fileset("../website/", "**/*.html")

  bucket = aws_s3_bucket.s3bucket.bucket
  key    = each.value
  source = "../../mywebsite/${each.value}"
  etag   = filemd5("../../mywebsite/${each.value}")
  content_type = "text/html"
}