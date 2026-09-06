resource "aws_instance" "my-ec2" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  key_name = "key-singapore"
  tag = {
    name = "tf-instance"
  }

}