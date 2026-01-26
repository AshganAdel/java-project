module "vpc" {
   source = "./modules/vpc"
   vpc_cidr = "10.42.0.0/16"
   vpc_name = "new_vpc"
}

module "subnet" {
   source = "./modules/subnet"
   public_cidr = ["10.42.1.0/24","10.42.2.0/24"]
   public_name = ["public_subnet","public_subnet_1"]
   vpc_id = module.vpc.vpc_id
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./modules/route_table"
  public_subnet = [module.subnet.public_subnet_id[0],module.subnet.public_subnet_id[1]]
  vpc_id = module.vpc.vpc_id
  igw = module.igw.igw_id
}

module "sg" {
  source = "./modules/security_group"
  sg_name = "jenkins_server_sg"
  vpc_id = module.vpc.vpc_id
  alb_sg_name = "alb_sg"

}

module "ec2" {
  source = "./modules/ec2"
  ami = "ami-01fd6fa49060e89a6"
  subnet_id = module.subnet.public_subnet_id[0]
  instance_name = "jenkins_server"
  instance_type = "m7i-flex.large"
  sg = module.sg.sg_id
  key_file_name = "/home/ashgan/.ssh/ec2_key.pem"
}

module "alb" {
  source = "./modules/alb"
  instance_id = module.ec2.ec2_id
  vpc_id = module.vpc.vpc_id
  alb_sg = [module.sg.alb_sg_id]
  public_subnets = module.subnet.public_subnet_id
}


