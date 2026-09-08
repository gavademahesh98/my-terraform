resource "aws_vpc" "my_vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}

resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet"
    }

}

resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.32.0/20"
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "private_subnet"
    }
}

resource "aws_internet_gateway" "my_igw"{
    vpc_id = aws_vpc.my_vpc.id
    tags ={
        Name = "my_igw"
    }
}

resource "aws_eip" "my_eip"{
    domain = "vpc"
    tags ={
        Name = "my_eip"
    }
}

resource "aws_nat_gateway" "my_nat"{
    allocation_id = aws_eip.my_eip.id
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "my_nat"
    }
}

resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route  {
        gateway_id = aws_internet_gateway.my_igw.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        Name = "public_rt"
    }
}

resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route  {
        nat_gateway_id = aws_nat_gateway.my_nat.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        Name = "private_rt"
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
    name = "my_security_group"
    description = "Allow SSH and http"

    ingress {
        from_port =22
        to_port = 22
        protocol =  "tcp"
        cidr_blocks= ["0.0.0.0/0"]
    }

    ingress {
        from_port =80
        to_port= 80
        protocol= tcp
        cidr_blocks= ["0.0.0.0/0"]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name ="my_security_group"
    }
}


resource "aws_key_pair" "my_key"{
    key_name = "yogu_key"
    public_key = file("/root/.ssh/id_ed25519.pub")
}

resource "aws_instance" "public_instance"{
    ami = "ami-0532913178263be11"
    instance_type = "t3.micro"
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    user_data_base64 = filebase64("/root/my-terraform/day-3-vpc2/userdata.sh")
    tags ={
        Name = "public_instance"
    }
}

resource "aws_instance" "private_instance"{
    ami = "ami-0532913178263be11"
    instance_type = "t3.micro"
    key_name = aws_key_pair.my_key.key_name
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids= [aws_security_group.my_sg.id]
    user_data_base64 = filebase64("/root/my-terraform/day-3-vpc2/userdata.sh")
    tags = {
        name = "private_instance"
    }

}