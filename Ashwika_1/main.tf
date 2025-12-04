resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.project_name}-VPC"
    Project = var.project_name
  }
}

# Resource 2: Public Subnets (using for_each for multiple instances)
resource "aws_subnet" "public" {
  for_each          = toset(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[index(var.public_subnet_cidrs, each.value)]

  map_public_ip_on_launch = true # Required for instances in public subnets

  tags = {
    Name    = "${var.project_name}-PublicSubnet-${index(var.public_subnet_cidrs, each.value) + 1}"
    Tier    = "Public"
    Project = var.project_name
  }
}

# Resource 3: Private Subnets
resource "aws_subnet" "private" {
  for_each          = toset(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[index(var.private_subnet_cidrs, each.value)]

  tags = {
    Name    = "${var.project_name}-PrivateSubnet-${index(var.private_subnet_cidrs, each.value) + 1}"
    Tier    = "Private"
    Project = var.project_name
  }
}

# Resource 4: Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.project_name}-IGW"
    Project = var.project_name
  }
}

# Resource 5: Public Route Table (for internet access)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Traffic to anywhere
    gateway_id = aws_internet_gateway.main.id # Go through the IGW
  }

  tags = {
    Name    = "${var.project_name}-Public-RT"
    Project = var.project_name
  }
}

# Resource 6: Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Resource 7: Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.main] # Best practice to ensure IGW is ready

  tags = {
    Name    = "${var.project_name}-NAT-EIP"
    Project = var.project_name
  }
}

# Resource 8: NAT Gateway (placed in the FIRST public subnet)
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["10.0.1.0/24"].id # Using the first public subnet

  tags = {
    Name    = "${var.project_name}-NAT-GW"
    Project = var.project_name
  }
}

# Resource 9: Private Route Table (for outbound access via NAT GW)
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.main.id

  # Add route for all internet-bound traffic to the NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name    = "${var.project_name}-Private-RT-${each.key}"
    Project = var.project_name
  }
}

# Resource 10: Associate Private Subnets with the Private Route Table
resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}