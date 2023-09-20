output "bucket_name" {
  value = var.bucket_name
}

output "bucket_id" {
  value = aws_s3_bucket.web_bucket.id
}
