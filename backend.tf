terraform {
  
  backend "s3" {
    bucket = "devtf-stratusgrid-state"
    encrypt = true
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }

}

