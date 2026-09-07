resource  "aws_key_pair" "classic_key"{
    key_name = var.key_name
    public_key = var.public_key_path
}


resource "aws_instance" "my-ec2"{
  ami = var.ami
  instance_type =var.instance_type
  key_name =aws_key_pair.clssic_key.key_name
  user_data_base64 = filebase64(var.user_data_file)
  tags = {
     Name = var.instance_name
  }
}