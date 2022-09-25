resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 2048

  provisioner "local-exec" {
    command     = <<EOT
    '${tls_private_key.ssh-key.private_key_pem}' | % {$_ -replace "`r", ""} | Set-Content -NoNewline ./'${var.keyname}.pem' -Force
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "aws_key_pair" "generated-key" {
  key_name   = var.keyname
  public_key = tls_private_key.ssh-key.public_key_openssh
}

resource "aws_instance" "ioana-instance-1"{
	ami                    = "${var.instance_AMI}"
	instance_type          = "${var.instance_type}"
	subnet_id              = "${aws_subnet.ioana-public-subnet-1.id}"
	vpc_security_group_ids = ["${aws_security_group.ioana-sg-ssh.id}"]
    key_name               = aws_key_pair.generated-key.key_name
	connection {
		user = "${var.ec2_user}"
		host = self.myip
	}
		tags = {
			Name                   = "ioana-instance-1"
            "KeepInstanceRunning" = "false"
		}
}

resource "aws_instance" "ioana-instance-2"{
	ami                    = "${var.instance_AMI}"
	instance_type          = "${var.instance_type}"
	subnet_id              = "${aws_subnet.ioana-public-subnet-2.id}"
	vpc_security_group_ids = ["${aws_security_group.ioana-sg-ssh.id}"]
    key_name               = aws_key_pair.generated-key.key_name
	connection {
		user = "${var.ec2_user}"
		host = self.myip
	}
		tags = {
		    Name                  = "ioana-instance-2"
            "KeepInstanceRunning" = "false"
	    }
}

resource "aws_instance" "ioana-instance-3"{
	ami                    = "${var.instance_AMI}"
	instance_type          = "${var.instance_type}"
	subnet_id              = "${aws_subnet.ioana-private-subnet-1.id}"
	vpc_security_group_ids = ["${aws_security_group.ioana-sg-private.id}"]
     key_name              = aws_key_pair.generated-key.key_name
	connection {
		user = "${var.ec2_user}"
		host = self.myip
	}
		tags = {
			Name                  = "ioana-instance-3"
            "KeepInstanceRunning" = "false"
		}
}
