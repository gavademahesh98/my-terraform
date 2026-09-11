resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags ={ 
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_sub_cidr
    map_public_ip_on_launch = true
    availability_zone = var.public_sub_az
    tags ={
        Name = "public-subnet"
    }
}

resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_sub_cidr
    availability_zone = var.private_sub_az
    map_public_ip_on_launch = false
    tags ={
        Name = "private-subnet"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags ={
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
    subnet_id = aws_subnet.public_subnet.id
    tags ={
        Name = var.nat_name
    }
}

resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        gateway_id = aws_internet_gateway.my_igw.id
        cidr_block = "0.0.0.0/0"
    }
    tags ={
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
    name = var.sg_name
    description = "ssh and http"
    ingress {
        from_port= var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
        ingress {
        from_port= var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }

    egress {
         from_port= 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }
}