variable "bucket_name" {
  type        = string
  description = "Name of the bucket"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for every element"
}

variable "website_content" {
  type        = set(string)
  description = "Set of contents to upload"
}
