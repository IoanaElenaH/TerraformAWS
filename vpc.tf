terraform {
  backend "s3" {
    key        = "terraform/tfstate.tfstate"
    bucket     = "state-files-for-terraform"
    region     = "eu-central-1"
    access_key = ""
    secret_key = ""
  }
}

resource "aws_vpc" "ioana-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "ioanavpc"
  }
}

resource "aws_subnet" "ioana-public-subnet-1" {
  cidr_block              = "${var.public_subnet_1_cidr}"
  vpc_id                  = "${aws_vpc.ioana-vpc.id}"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "ioana-public-subnet-2" {
  cidr_block              = "${var.public_subnet_2_cidr}"
  vpc_id                  = "${aws_vpc.ioana-vpc.id}"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Public-Subnet-2"
  }
}

resource "aws_subnet" "ioana-private-subnet-1" {
  cidr_block              = "${var.private_subnet_1_cidr}"
  vpc_id                  = "${aws_vpc.ioana-vpc.id}"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "Private-Subnet-1"
  }
}

resource "aws_subnet" "ioana-private-subnet-2" {
  cidr_block              = "${var.private_subnet_2_cidr}"
  vpc_id                  = "${aws_vpc.ioana-vpc.id}"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "Private-Subnet-2"
  }
}