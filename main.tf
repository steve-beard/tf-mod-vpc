// Define local variables
locals {

  // Define public subnets
  public_subnets = { for i, az in var.azs : "public${i + 1}" => { cidr = cidrsubnet(var.base_cidr, 8, i), name = "public${i + 1}-subnet", az = az } }
  // Define private subnets
  private_subnets = {
    app              = { for i, az in var.azs : "app${i + 1}" => { cidr = cidrsubnet(var.base_cidr, 8, i), name = "app${i + 1}-subnet", az = az } }
    db               = { for i, az in var.azs : "db${i + 1}" => { cidr = cidrsubnet(var.base_cidr, 8, i), name = "db${i + 1}-subnet", az = az } }
    internal         = { for i, az in var.azs : "internal${i + 1}" => { cidr = cidrsubnet(var.base_cidr, 8, i), name = "internal${i + 1}-subnet", az = az } }
    firewall_subnets = var.firewall ? { for i, az in var.azs : "firewall${i + 1}" => { cidr = cidrsubnet(var.base_cidr, 12, i), name = "firewall${i + 1}-subnet", az = az } } : {}
  }
}
// Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr
  tags = merge(
    {
      Name = var.vpc_name
    },
    var.tags
  )

}

// Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = "${var.vpc_name}-gw}"
    },
    var.tags
  )

}

// Create an Elastic IP for each NAT Gateway
resource "aws_eip" "nat" {
  count = var.create_nat_gateway ? length(var.azs) : 0

  domain = "vpc"

  tags = merge(
    {
      Name = "${var.vpc_name}-nat-eip-${count.index + 1}"
    },
    var.tags
  )
}

// Create a NAT Gateway in each public subnet
resource "aws_nat_gateway" "nat" {
  count = var.create_nat_gateway ? length(var.azs) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = tolist(aws_subnet.public.*.id)[count.index]

  tags = merge(
    {
      Name = "${var.vpc_name}-nat-gw-${count.index + 1}"
    },
    var.tags
  )
}

// Create public subnets
resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = each.value.name
    },
    var.tags
  )
}

// Create a route table for each public subnet and associate it
resource "aws_route_table" "public" {
  for_each = aws_subnet.public

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    {
      Name = "${each.value.name}-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each = aws_route_table.public

  subnet_id      = each.value.id
  route_table_id = each.value.id

}

// Create private subnets
resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(
    {
      Name = each.value.name
    },
    var.tags
  )
}

// Create a route table for each private subnet and associate it
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, index(keys(aws_subnet.private), each.key))
  }

  tags = merge(
    {
      Name = "${each.value.name}-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  for_each = aws_route_table.private

  subnet_id      = each.value.id
  route_table_id = each.value.id
}

// Create firewall subnets
resource "aws_subnet" "firewall" {
  for_each = local.private_subnets.firewall_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

}

// Create a route table for each firewall subnet and associate it
resource "aws_route_table" "firewall" {
  for_each = aws_subnet.firewall

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, index(keys(aws_subnet.private), each.key))
  }

  tags = merge(
    {
      Name = "${each.value.tags.Name}-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "firewall" {
  for_each = aws_route_table.firewall

  subnet_id      = each.value.id
  route_table_id = each.value.id
}