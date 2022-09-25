## TerraformAWS
***
Creating a custom VPC and deploying three EC2 VMs using Terraform.
***
VPC with range 10.0.0.0/16

| Public subnets       | Private Subnets|
| ---------------------|:--------------:|
| 10.0.1.0/24          | 10.0.128.0/24  | 
| 10.0.2.0/24          | 10.0.129.0/24  |   
***
- 2 EC2 t3.micro instances, connected to each of the public subnets (rules: tcp/22, only from your public IP and tcp/80 from any IP)
- 1 EC2 t3.micro instance, connected to one of the private subnets
- one of the public EC2 instances can connect via tcp/22 to the private EC2 instance
