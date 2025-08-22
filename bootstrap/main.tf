terraform {
  backend "s3" {
    # set via backend.hcl at init
  }
}

provider "aws" {
  region = "us-east-2"
}

locals {
  name_prefix = "${var.project}-${var.environment}"
}

# S3 backend bucket
resource "aws_s3_bucket" "tf_state" {
  bucket = "${local.name_prefix}-tfstate"
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle {
    prevent_destroy = true
  }
}

# DynamoDB lock table
resource "aws_dynamodb_table" "tf_lock" {
  name         = "${local.name_prefix}-tf-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# IAM/OIDC moved into module
module "iam" {
  source      = "../modules/iam"
  name_prefix = local.name_prefix
  github_org  = var.github_org
  github_repo = var.github_repo
}

output "tf_state_bucket" { value = aws_s3_bucket.tf_state.bucket }
output "tf_lock_table"  { value = aws_dynamodb_table.tf_lock.name }
