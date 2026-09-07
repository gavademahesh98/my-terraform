# VPC Create

resource "aws_vpc" "my_vpc"{
       cidr_block = "10.0.0.0/16"
       tags ={
          Name = "my-vpc"
       }
}

resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = true
    tags ={
        Name = "public-subnet"
    }
}

resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block  = "10.0.32.0/20"
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet"
    }
}

resource "aws_internet_gateway" "IGW"{
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "my-igw"
    }
}


resource "aws_eip" "my_eip"{
    domain = "vpc"
    tags = {
        Name ="my_eip"
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
        gateway_id = aws_internet_gateway.IGW.id
        cidr_block = "0.0.0.0/0"
    }
    tags ={
        Name = "public_rt"
    }
}

resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route{
        nat_gateway_id = aws_nat_gateway.my_nat.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        Name = "private_rt"
    }
}

resource "aws_route_table_association" "public_rt_association"{
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet.id

}

resource "aws_route_table_association" "private_rt_association"{
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet.id

}


resource "aws_security_group" "sg"{
    vpc_id = aws_vpc.my_vpc.id
    name = "my-sg"
    description = "my-sg"

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
        Name = "my-tf-sg"
    }
}