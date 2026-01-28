variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
}
variable "sg1_name" {
  type = string
}
variable "ec2_name" {
  type = string
}
variable "key_name" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "volume_size" {
  
}