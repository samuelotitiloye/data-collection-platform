resource "aws_s3_bucket_policy" "data_collection_platform" {
  bucket = "data-collection-platform"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowGHARoleAccess"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/gha_deploy"
        }
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::data-collection-platform",
          "arn:aws:s3:::data-collection-platform/*"
        ]
      }
    ]
  })
}
