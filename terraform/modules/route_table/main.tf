resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public-rt-as" {
  subnet_id      = var.public_subnet[0]
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "public-rt-as2" {
  subnet_id      = var.public_subnet[1]
  route_table_id = aws_route_table.public-rt.id
}



