
 resource "aws_key_pair" "my_key" {
    key_name = var.key_name
    public_key = file(var.public_key_path)

}

resource "aws_instance" "my-ec2" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.my_key.key_name
  user_data_base64= filebase64(var.user_data_file)
  tags ={

    Name = var.instance_name
  }
}

