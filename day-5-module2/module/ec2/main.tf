resource "aws_key_pair" "my_key" {
    key_name = var.key_name
    public_key = file(var.pub_key_path)
}



resource "aws_instance" "public_instance"{
    ami = var.ami 
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.id
    subnet_id = var.pub_sub_id
    vpc_security_group_ids = [var.sg_id]
   root_block_device{
    volume_size = var.volume_size
    volume_type = var.volume_type
   }
   tags = {
    Name = var.pub_instance_name
   }
}

resource "aws_instance" "private_instance"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.id
    subnet_id = var.pvt_sub_id
    vpc_security_group_ids = [var.sg_id]
    root_block_device{
        volume_size = var.volume_size
        volume_type = var.volume_type
    }
    tags ={
        Name = var.pvt_instance_name
    }
}