terraform {
  	backend "s3" {
    	key        = "terraform/tfstate.tfstate"
		acl        = "private"
    	bucket     = "state-files-for-terraform"
    	region     = "eu-central-1"
  	}
}