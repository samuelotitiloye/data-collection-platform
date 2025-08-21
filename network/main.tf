locals { name = "${var.project}-${var.environment}-vpc" }

module "vpc" {
  source               = "../modules/vpc"
  name                 = local.name
  cidr                 = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gw        = var.enable_nat_gw
}

output "vpc_id"             { value = module.vpc.vpc_id }
output "public_subnet_ids"  { value = module.vpc.public_subnet_ids }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }
