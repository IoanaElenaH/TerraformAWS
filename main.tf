resource "aws_instance" "ioana-instance-1"{
	ami                    = var.instance_AMI
	instance_type          = var.instance_type
	subnet_id              = aws_subnet.ioana-public-subnet-1.id
	vpc_security_group_ids = [aws_security_group.ioana-sg-ssh.id]
    key_name               = aws_key_pair.ioana-generated-key.key_name
	user_data 			   = file("${var.user_data_path}")
		tags = {
			Name                   = "${var.owner}-instance-1"
            "KeepInstanceRunning"  = "false"
		}
}

resource "aws_instance" "ioana-instance-2"{
	ami                    = var.instance_AMI
	instance_type          = var.instance_type
	subnet_id              = aws_subnet.ioana-public-subnet-2.id
	vpc_security_group_ids = [aws_security_group.ioana-sg-ssh.id]
    key_name               = aws_key_pair.ioana-generated-key.key_name
	user_data 			   = file("${var.user_data_path}")
		tags = {
		    Name                  = "${var.owner}-instance-2"
            "KeepInstanceRunning" = "false"
	    }
}

resource "aws_instance" "ioana-instance-3"{
	ami                    = var.instance_AMI
	instance_type          = var.instance_type
	subnet_id              = aws_subnet.ioana-private-subnet-1.id
	vpc_security_group_ids = [aws_security_group.ioana-sg-private.id]
    key_name              = aws_key_pair.ioana-generated-key.key_name
	user_data 			   = file("${var.user_data_path}")
		tags = {
			Name                  = "${var.owner}-instance-3"
            "KeepInstanceRunning" = "false"
		}
}