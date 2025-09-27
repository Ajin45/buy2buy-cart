
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
