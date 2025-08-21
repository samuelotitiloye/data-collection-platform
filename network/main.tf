locals {
  name = "${var.project}-${var.environment}-vpc"
}

# Call the reusable VPC module
module "vpc" {
  source               = "../modules/vpc"
  name                 = local.name
  cidr                 = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gw        = var.enable_nat_gw
}

# Outputs from the VPC module
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

# Security Group (kept at network layer, not in the module)
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default SG for ${var.environment}"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-sg"
    Environment = var.environment
  }
}

output "security_group_id" {
  value = aws_security_group.default.id
}
