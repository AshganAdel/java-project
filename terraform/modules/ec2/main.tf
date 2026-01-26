resource "aws_instance" "example_instance" {
  ami           = var.ami
  instance_type = var.instance_type 
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg]
  key_name = aws_key_pair.generated_key.key_name
  tags = {
    Name = var.instance_name
  }
}
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = var.key_file_name
  file_permission = "0400"
}
