resource "aws_key_pair" "key_pair"{
    key_name = var.key_name
    public_key = file(var.public_key_path)
}


resource "aws_instance" "my-Ec2"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.key_pair.key_name
    user_data_base64 = filebase64(var.script_path)
    tags = {
        Name = var.instance_name
    }
}