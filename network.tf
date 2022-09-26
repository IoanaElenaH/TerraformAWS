resource "aws_internet_gateway" "ioana-gateway"{
	vpc_id = aws_vpc.ioana-vpc.id
	tags = {
		Name = "${var.owner}-gateway"
	}
}

resource "aws_route_table" "ioana-public-rt"{
	vpc_id = aws_vpc.ioana-vpc.id
	route{
		cidr_block = var.cidr_block
		gateway_id = aws_internet_gateway.ioana-gateway.id
	}
	tags = {
		Name = "${var.owner}-public-route-table"
	}
}

resource "aws_route_table_association" "ioana-rt-public-subnet-1"{
	subnet_id      = aws_subnet.ioana-public-subnet-1.id
	route_table_id = aws_route_table.ioana-public-rt.id
}

resource "aws_route_table_association" "ioana-rt-public-subnet-2" {
	subnet_id      = aws_subnet.ioana-public-subnet-2.id
	route_table_id = aws_route_table.ioana-public-rt.id
}

resource "aws_route_table_association" "ioana-rt-private-subnet-1"{
	subnet_id      = aws_subnet.ioana-private-subnet-1.id
	route_table_id = aws_route_table.ioana-public-rt.id
}