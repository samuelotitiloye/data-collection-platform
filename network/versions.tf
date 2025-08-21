variable "aws_region" {
  type    = string
  default = "us-east-2"
}
variable "project" { 
    type = string 
    default = "data-collection-platform" 
}
variable "environment"{ 
    type = string 
    default = "prod-approval" 
}

variable "vpc_cidr" { 
    type = string 
    default = "10.0.0.0/16" 
}
variable "public_subnet_cidrs"  { 
    type = list(string) 
    default = ["10.0.0.0/24","10.0.1.0/24"] 
}
variable "private_subnet_cidrs" { 
    type = list(string) 
    default = ["10.0.10.0/24","10.0.11.0/24"] 
}
variable "enable_nat_gw" { 
    type = bool 
    default = true 
}