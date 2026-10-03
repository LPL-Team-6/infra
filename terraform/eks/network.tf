data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "caseauth" {
  cidr_block           = "10.42.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { Name = "caseauth-hackathon" }
}

resource "aws_internet_gateway" "caseauth" {
  vpc_id = aws_vpc.caseauth.id
  tags   = { Name = "caseauth-hackathon" }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.caseauth.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.caseauth.cidr_block, 8, count.index + 1)
  map_public_ip_on_launch = true

  tags = { Name = "caseauth-public-${count.index + 1}" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.caseauth.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.caseauth.id
  }

  tags = { Name = "caseauth-public" }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
