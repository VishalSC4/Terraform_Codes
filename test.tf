/*
provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "JK" {
    for_each = {
    app = "appserver"
    web= "webserver"
    }
    ami = var.my_ami
    instance_type = var.my_instance
    subnet_id = var.my_subnet_id[each.key]
    vpc_security_group_ids = [var.my_sg77]
   user_data = <<-EOF
   #!/bin/bash
sudo yum update
sudo yum install httpd -y
sudo systemctl start httpd
cd /var/www/html
echo "<h1>I'm doing the heredoc</h1>"   > index.html


   EOF
    tags = {
      Name = each.key
    }
 
}
output "public_ips" {
    value = {
        for k, v in aws_instance.JK :
        k => v.public_ip
    }
  
}

*/




