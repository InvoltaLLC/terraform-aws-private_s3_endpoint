data "aws_region" "current" {}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  tags = var.tags
}

resource "aws_vpc_endpoint_policy" "s3" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Allow-access-to-specific-bucket",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
           "s3:ListBucket",
           "s3:GetObject",
           "s3:PutObject"
        ],
        "Resource": concat(formatlist("arn:aws:s3:::%s",var.allowed_buckets),formatlist("arn:aws:s3:::%s/*",var.allowed_buckets))
      }
    ]
  })
}