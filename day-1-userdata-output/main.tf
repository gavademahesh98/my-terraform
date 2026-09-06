resource  "aws_instance" "my_ec2"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    user_data_base64 =filebase64(var.file_path)
    tags ={
        Name = var.instance_name
    }
}