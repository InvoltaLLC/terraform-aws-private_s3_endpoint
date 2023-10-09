resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  for_each = toset(var.allowed_buckets)
  
  bucket = each.key
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Allow-access-to-specific-VPC",
        "Effect": "Deny",
        "Principal": "*",
        "Action": ["s3:*Object", "s3:ListBucket"],
        "Resource": ["arn:aws:s3:::${each.key}",
                     "arn:aws:s3:::${each.key}/*"],
        "Condition": {
          "StringNotEquals": {
            "aws:sourceVpc": var.vpc_id
          },
          "StringEqualsIgnoreCase" : { "aws:username" : "johndoe" }
        }
      }
    ]
  })
}
