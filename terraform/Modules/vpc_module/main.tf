
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

#creating  public-subnet

resource "aws_subnet" "public_subnets" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.cidr-block, var.cidrnewbit, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.VpcNameTag}_public_${1 + count.index}"
  }
}

#local variable to find number of public_subnet

locals {
  Total_public_subnets = length(aws_subnet.public_subnets)

}

#creating private subnet

resource "aws_subnet" "private_subnets" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.cidr-block, var.cidrnewbit, local.Total_public_subnets + count.index)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.VpcNameTag}_private_${1 + count.index}"
  }
}

#Creating public routeTable 

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.VpcNameTag}-public-route-table"
  }
}

#routes

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_vpc_igw.id
}

# route table association
resource "aws_route_table_association" "public_subnet" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# creating elastic IP

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.VpcNameTag}nat-eip"
  }
}


#Creating NAT gateway

resource "aws_nat_gateway" "private_route" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[1].id

  tags = {
    Name = "${var.VpcNameTag}_nat_gateway"

  }


  depends_on = [
    aws_internet_gateway.main_vpc_igw,
    aws_eip.nat_eip
  ]
}



# creating private route-table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.VpcNameTag}-private-route-table"
  }

}

#routes

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private_route.id
}

#private route table association

resource "aws_route_table_association" "private_subnet" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}




