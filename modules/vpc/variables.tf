variable "name" { type = string }
variable "cidr" { type = string }
variable "az_count" { 
    type = number 
    default = 2 
}
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "enable_nat_gw" { 
    type = bool 
    default = true 
}