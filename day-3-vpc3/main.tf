resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_subnet_az
    map_public_ip_on_launch = true
    tags ={
        Name = var.public_subnet_name
    }
}

resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.private_subnet_az
    map_public_ip_on_launch = false
    tags ={
        Name = var.private_subnet_name
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "my_igw"
    }
}

resource "aws_eip" "my_eip"{
    domain = "vpc"
    tags = {
        Name = "my_eip"
    }
}

resource "aws_nat_gateway" "my_nat"{
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.public_subnet.id
    tags ={
        Name = "my_nat"
    }
}

resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route{
        gateway_id = aws_internet_gateway.my_igw.id
        cidr_block = "0.0.0.0/0"
    }
    tags ={
        Name = "public_rt"
    }
}

resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        nat_gateway_id = aws_nat_gateway.my_nat.id
        cidr_block = "0.0.0.0/0"
    }
}

resource "aws_route_table_association" "public_subnet_association"{
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet.id

}

resource "aws_route_table_association" "private_subnet_association"{
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet.id

}


resource "aws_security_group" "my_sg"{
    vpc_id = aws_vpc.my_vpc.id
    name = "only_mine_sg"
    description = "only_mine_sg"

    ingress{
        from_port= var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks= ["0.0.0.0/0"]
    }
    tags ={
        Name = var.security_group_name
    }
}

resource "aws_key_pair" "my_key"{
    key_name = var.key_name
    public_key = file("/root/.ssh/id_ed25519.pub")
}

resource "aws_instance" "public_instance"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids =[aws_security_group.my_sg.id]
    user_data_base64 = filebase64 ("/root/my-terraform/day-3-vpc3/userdata.sh")
    root_block_device{
        volume_size = var.volume_size
        volume_type = var.volume_type
    }
    tags ={
        Name = var.public_instance_name
    }
}


resource "aws_instance" "private_instance"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    user_data_base64 = filebase64 ("/root/my-terraform/day-3-vpc3/userdata.sh")
    root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
    }
    tags = {
        Name = var.private_instance_name
    }
}

