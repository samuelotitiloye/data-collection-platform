resource "aws_iam_role" "gha_deploy" {
  name = "${var.name_prefix}-gha-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Federated = aws_iam_openid_connect_provider.github.arn }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = { "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com" }
          StringLike   = { "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/${var.github_repo}:*" }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "gha_deploy_policy" {
  name        = "${var.name_prefix}-gha-deploy-policy"
  description = "Least-priv for Terraform backend + VPC"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Backend S3 + DDB
      {
        Effect = "Allow"
        Action = ["s3:*"]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = ["dynamodb:*"]
        Resource = ["*"]
      },
      # VPC minimal (later you’ll scope tighter)
      {
        Effect = "Allow"
        Action = ["ec2:*"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = ["iam:PassRole"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "gha_deploy_attach" {
  role       = aws_iam_role.gha_deploy.name
  policy_arn = aws_iam_policy.gha_deploy_policy.arn
}
