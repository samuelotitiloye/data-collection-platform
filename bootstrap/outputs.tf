output "backend_bucket" { value = aws_s3_bucket.tf_state.bucket }
output "backend_table"  { value = aws_dynamodb_table.tf_lock.name }
//output "oidc_provider_arn" { value = aws_iam_openid_connect_provider.github.arn }
//output "gha_role_arn" { value = aws_iam_role.gha_deploy.arn }


