resource "aws_subnet" "public" {
  count = length(var.public_name)
  vpc_id     = var.vpc_id
  map_public_ip_on_launch = true
  cidr_block = var.public_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = var.public_name[count.index]
  }
}



