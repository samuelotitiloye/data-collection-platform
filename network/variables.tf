variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID from baseline module"
  type        = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones to use"
  default     = ["us-east-1a", "us-east-1b"]
}
