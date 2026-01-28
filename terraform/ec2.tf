resource "aws_instance" "test" {
  subnet_id = module.my_vpc.public_subnets[0]
  instance_type = var.instance_type
  ami = var.ami 
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg1.id]
  key_name = var.key_name
  root_block_device {
    volume_size = var.volume_size
  }
  tags = {
    Name = var.ec2_name
  }
}

resource "aws_security_group" "sg1" {
  name = var.sg1_name 
  vpc_id = module.my_vpc.vpc_id
  ingress {
    description     = "Kube API Server"
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

