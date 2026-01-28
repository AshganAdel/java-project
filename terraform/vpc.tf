module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway  = true
 
}