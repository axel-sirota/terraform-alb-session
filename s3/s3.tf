resource "aws_s3_bucket" "web_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = var.common_tags
}

resource "aws_s3_object" "website_content" {
  for_each = var.website_content
  bucket   = aws_s3_bucket.web_bucket.id
  key      = each.value
  source   = "${path.root}/${each.value}"
  tags     = var.common_tags
}
