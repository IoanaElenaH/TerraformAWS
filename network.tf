resource "aws_internet_gateway" "ioana-gateway"{
	vpc_id = "${aws_vpc.ioana-vpc.id}"
	tags = {
		Name = "ioana-gateway"
	}
}

resource "aws_route_table" "ioana-public-rt"{
	vpc_id = "${aws_vpc.ioana-vpc.id}"
	route{
		cidr_block = "${var.cidr_block}"
		gateway_id = "${aws_internet_gateway.ioana-gateway.id}"
	}
	tags = {
		Name = "ioana-public-rt"
	}
}

resource "aws_route_table_association" "ioana-rt-public-subnet-1"{
	subnet_id      = "${aws_subnet.ioana-public-subnet-1.id}"
	route_table_id = "${aws_route_table.ioana-public-rt.id}"
}

resource "aws_route_table_association" "ioana-rt-public-subnet-2"{
	subnet_id      = "${aws_subnet.ioana-public-subnet-2.id}"
	route_table_id = "${aws_route_table.ioana-public-rt.id}"
}

resource "aws_route_table_association" "ioana-rt-private-subnet-1"{
	subnet_id      = "${aws_subnet.ioana-private-subnet-1.id}"
	route_table_id = "${aws_route_table.ioana-public-rt.id}"
}

data "http" "myip"{
    url = "http://ipv4.icanhazip.com" //powershell >> nslookup myip.opendns.com resolver1.opendns.com
}

resource "aws_security_group" "ioana-sg-ssh"{
    description = "Allow inbound traffic via SSH"
    vpc_id      = "${aws_vpc.ioana-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
   
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${var.cidr_block}"]
  }
  tags = {
    Name = "ioana-sg"
  }
} 

resource "aws_security_group" "ioana-sg-private"{
  vpc_id = "${aws_vpc.ioana-vpc.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.public_subnet_1_cidr}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${var.cidr_block}"]
  }
  tags = {
    Name = "ioana-sgp"
  }
} 