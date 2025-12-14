terraform {
  backend "s3" {
    bucket = "terraform-upload-bucket99"
    key = "terraform.tfstate"
    region = "ap-south-1"
    
  }
}
provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "Kaam" {
ami = "ami-00ca570c1b6d79f36"
instance_type = "t2.micro"
key_name = "Vishal"
subnet_id = "subnet-0efa95655268209d2"

  
}