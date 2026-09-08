resource "aws_vpc" "my_vpc"{
    cidr_block = var.vpc_cidr
    tags ={
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public_subnet1"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet1_cidr
    availability_zone = var.public_subnet1_az
    map_public_ip_on_launch = true
    tags ={
        Name = "public-subnet1"
    }
}

resource "aws_subnet" "public_subnet2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet2_cidr
    availability_zone = var.public_subnet2_az
    map_public_ip_on_launch = true
    tags ={
        Name = "public-subnet2"
    }
}

resource "aws_subnet" "private_subnet1"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet1_cidr
    availability_zone = var.private_subnet1_az
    map_public_ip_on_launch = false
    tags ={
        Name = "private-subnet1"
    }
}

resource "aws_subnet" "private_subnet2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet2_cidr
    availability_zone = var.private_subnet2_az
    tags = {
        Name = "private-subnet2"
    }
}

resource "aws_internet_gateway" "my_igw"{
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = var.igw_name
    }
}

resource "aws_eip" "my_eip"{
    domain = "vpc"
    tags ={
        Name = var.eip_name
    }
}


resource "aws_nat_gateway" "my_nat"{
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.public_subnet1.id
    tags= {
        Name = var.nat_gateway_name
    }
}


resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        gateway_id = aws_internet_gateway.my_igw.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        nat_gateway_id = aws_nat_gateway.my_nat.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        Name = "private-rt"
    }
}

resource "aws_route_table_association" "public_subnet1_association"{
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet1.id

}

resource "aws_route_table_association" "public_subnet2_association"{
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet2.id

}

resource "aws_route_table_association" "private_subnet1_association"{
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet1.id
}

resource "aws_route_table_association" "private_subnet2_association"{
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet2.id

}


resource "aws_security_group" "dev_sg"{
    vpc_id = aws_vpc.my_vpc.id
    name = var.security_group_name
    description = "allow SSH and http"
    ingress{
        from_port = var.ssh_port
        to_port =var.ssh_port
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.security_group_name
    }
}




resource "aws_key_pair" "my_key"{
    key_name = var.key_name
    public_key = file ("/root/.ssh/id_ed25519.pub")
}

resource "aws_instance" "public_instance1"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.public_subnet1.id
    vpc_security_group_ids = [aws_security_group.dev_sg.id]
    user_data_base64= filebase64("/root/my-terraform/day-4-vpc4/userdata.sh")
    tags= {
        Name = "public-instance-1"
    }

}

resource "aws_instance" "public_instance2"{
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.public_subnet2.id
    vpc_security_group_ids =[aws_security_group.dev_sg.id]
    user_data_base64= filebase64("/root/my-terraform/day-4-vpc4/userdata.sh")
    tags ={
        Name = "public-instance-2"
    }

    
}