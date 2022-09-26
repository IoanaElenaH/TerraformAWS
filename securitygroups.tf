data "http" "myip"{
    url = "http://ipv4.icanhazip.com" //powershell >> nslookup myip.opendns.com resolver1.opendns.com
}

resource "aws_security_group" "ioana-sg-ssh"{
    description = "Allow inbound traffic via SSH"
    vpc_id      = aws_vpc.ioana-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
   
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.cidr_block]
  }
  tags = {
    Name = "${var.owner}-security-group-public-instance"
  }
} 

resource "aws_security_group" "ioana-sg-private"{
  vpc_id = aws_vpc.ioana-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_1_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    description = "Limit access"
    Name = "${var.owner}-security-group-private-instance"
  }
} 