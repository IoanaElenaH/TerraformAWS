variable "region" {
  default     = "eu-central-1"
  description = "AWS Region"
}

variable "cidr_block" {
  default     = "0.0.0.0/0"
  description = "CIDR Block for VPC"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR Block for VPC"
}

variable "public_subnet_1_cidr" {
  default     = "10.0.1.0/24"
  description = "CIDR Block for Public Subnet 1"
}

variable "public_subnet_2_cidr" {
  default     = "10.0.2.0/24"
  description = "CIDR Block for Public Subnet 2"
}

variable "private_subnet_1_cidr" {
  default     = "10.0.128.0/24"
  description = "CIDR Block for Private Subnet 1"
}

variable "private_subnet_2_cidr" {
  default     = "10.0.129.0/24"
  description = "CIDR Block for Private Subnet 2"
}

variable "keyname" {
  default     = "ioana-tfkey"
}

variable "instance_AMI"{
  default     = "ami-05ff5eaef6149df49"
  description = "AMI EC2 instance - t3"
}

variable "ec2_user"{
  default     = "ioana"
}

variable "instance_type" {
  default     = "t3.micro"
}
