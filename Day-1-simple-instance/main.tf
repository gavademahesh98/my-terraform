resource "aws_instance" "my-ec2" {
  ami = "ami-0532913178263be11"
  instance_type = "t3.micro"
  key_name = "key-singapore"
  tags = {
    Name = "tf-instance"
  }

}