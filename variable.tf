variable "my_ami" {
    default = "ami-00ca570c1b6d79f36"
  
}

variable "my_instance" {
    default = "t2.micro"
  
}

variable "my_sg77" {
    default = "sg-044074d5d66cf9eb2"
  
}

variable "my_subnet_id" {
   type = map(string)
   default = {
     "app" = "subnet-0efa95655268209d2"
     "web" = "subnet-0e5fe10dcfe91c353"
   }
  
}

variable "avail_zones" {
    type = list(string)
    default = ["ap-south-1a","ap-south-1b"]
  
}