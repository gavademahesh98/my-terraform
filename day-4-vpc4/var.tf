# VPC variables

variable "vpc_cidr"{
    default = "10.0.0.0/16"
}

variable "vpc_name"{
    default = "dev_vpc"
}

variable "public_subnet1_cidr"{
    default = "10.0.16.0/20"
}

variable "public_subnet1_az"{
    default = "ap-southeast-1a"
}


variable "public_subnet2_cidr"{
    default = "10.0.32.0/20"
}

variable "public_subnet2_az"{
    default = "ap-southeast-1b"
}

variable "private_subnet1_cidr"{
    default = "10.0.48.0/20"
}

variable "private_subnet1_az"{
    default = "ap-southeast-1a"
}


variable "private_subnet2_cidr"{
    default = "10.0.64.0/20"
}

variable "private_subnet2_az"{
    default = "ap-southeast-1b"
}

variable "igw_name"{
    default = "dev_igw"
}

variable "eip_name"{
    default = "dev_eip"
}

variable "nat_gateway_name"{
    default = "dev_nat"
}

variable "security_group_name"{
    default = "dev_sg"
}

variable "ssh_port"{
    default = 22
}

variable "http_port"{
    default = 80
}

variable "key_name"{
    default = "classic-key"
}

#  Instance Variables

variable "ami"{
    default = "ami-0532913178263be11"
}

variable "instance_type"{
    default = "t3.micro"
}
