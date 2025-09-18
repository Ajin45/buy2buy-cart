#creating vpc

resource "aws_vpc" "main_vpc" {

  cidr_block           = var.cidr-block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = var.VpcNameTag
  }

}

#creating internet gateway

resource "aws_internet_gateway" "main_vpc_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.VpcNameTag
  }
}

