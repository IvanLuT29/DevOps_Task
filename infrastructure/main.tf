provider "aws" {
  access_key = "Access Key"
  secret_key = "Secret_key"
  region = "eu-central-1"  
}

resource "aws_instance" "web_instance" {
  ami           = "ami-0b2ac948e23c57071"  # Укажите желаемый AMI ID
  instance_type = "t2.micro"      # Укажите желаемый тип инстанса
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
    Name = "WebServer"
  }

}
resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "WebServer"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }