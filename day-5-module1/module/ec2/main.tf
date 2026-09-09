resource "aws_key_pair" "my_key"{
    key_name = var.key_name
    public_key = file(var.pub_key_path)
}

resource "aws_instance" "public_instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    user_data_base64 =filebase64("/root/my-terraform/day-5-module1/module/ec2/userdata.sh")
    subnet_id = var.public_subnet_id
    vpc_security_group_ids =[var.sg_id]
    tags = {
        Name = "public_instance"
    }
}


resource "aws_instance" "private_instance"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    user_data_base64 =filebase64("/root/my-terraform/day-5-module1/module/ec2/userdata.sh")
    subnet_id = var.private_subnet_id
    vpc_security_group_ids =[var.sg_id]
    tags = {
        Name = "private_instance"
    }
}