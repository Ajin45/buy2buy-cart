
#creating security group

resource "aws_security_group" "general_security_group" {
  name   = "${var.project_name}_sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}_sg"
  }

  depends_on = [var.vpc_id]
}

#security group rules 

resource "aws_vpc_security_group_ingress_rule" "sgrule_for_frontend" {
  for_each          = toset(var.sgports)
  security_group_id = aws_security_group.general_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  to_port           = each.key
  ip_protocol       = "tcp"
}

#creating ec2-instance

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ami_from_packer.id
  instance_type          = "t3.micro"
  key_name               = data.aws_key_pair.study_key.key_name
  security_groups = [aws_security_group.general_security_group.id]
  subnet_id              = var.public_subnets[1]
  tags = {
    Name        = "WebServer"
    Environment = "dev"
  }
}
