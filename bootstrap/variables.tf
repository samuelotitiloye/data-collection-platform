variable "aws_region" {
  type        = string
  description = "AWS region to deploy backend + OIDC"
  default     = "us-east-2"
}

variable "project" {
  type        = string
  description = "data-collection-platform project name"
  default     = "data-collection-platform"
}

variable "environment" {
  type        = string
  description = "prod-approval"
  default     = "dev"
}

variable "github_org" {
  type        = string
  description = "GitHub organization or user (e.g., samuel)"
}

variable "github_repo" {
  type        = string
  description = "data-collection-platform"
}