# network.tf

#data "aws_vpc" "selected" {
#  id = var.vpc_id
#}

#data "aws_availability_zones" "available" {}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name                      = "eks-public-${count.index}"
    "kubernetes.io/role/elb" = 1
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 10)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name                                = "eks-private-${count.index}"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.selected.id
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.selected.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway for Private Subnets
resource "aws_eip" "nat_eip" {
#  vpc = true  # Seems like this line is depricated and no replacement annotation is required in this place
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.selected.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}