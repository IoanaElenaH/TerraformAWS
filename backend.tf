terraform {
  	backend "s3" {
    	key        = "terraform/tfstate.tfstate"
	acl        = "private"
    	bucket     = ">>>enter-your-bucket-name<<<"
    	region     = "eu-central-1"
  	}
}
