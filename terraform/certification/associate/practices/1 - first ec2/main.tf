resource "aws_instance" "web" {
  ami           = "ami-0d318f1f104612755"
  instance_type = "t3.micro"

  tags = {
    Name = "Test"
  }
}
