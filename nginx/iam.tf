resource "aws_iam_role" "allow_nginx_s3" {
  name = "${var.bucket_name}-allow_nginx_s3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.common_tags
}

resource "aws_iam_instance_profile" "nginx_profile" {
  name = "${var.bucket_name}-nginx_profile"
  role = aws_iam_role.allow_nginx_s3.name

  tags = var.common_tags
}

resource "aws_iam_role_policy" "allow_s3_all" {
  name = "${var.bucket_name}-allow_s3_all"
  role = aws_iam_role.allow_nginx_s3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
    }
  ]
}
EOF
}
