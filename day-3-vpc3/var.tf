variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "vpc_name"{
    default = "dev_vpc"
}

variable "public_subnet_cidr"{
    default = "10.0.16.0/20"
}

variable "public_subnet_az"{
    default = "ap-southeast-1a"
}

variable "public_subnet_name"{
    default = "public_subnet"
}

variable "private_subnet_cidr"{
    default = "10.0.32.0/20"
}

variable "private_subnet_az"{
    default = "ap-southeast-1b"
}

variable "private_subnet_name"{
    default = "private_subnet"
}


variable "ssh_port"{
    default = 22
}
variable "http_port"{
    default = 80
}

variable "security_group_name"{
    default = "mine_only_sg"
}

variable "key_name"{
    default = "dev_key"
}

variable "ami"{
    default = "ami-0532913178263be11"
}

variable "instance_type"{
    default = "t3.micro"
}

variable "volume_size"{
    default = 10
}

variable "volume_type"{
    default = "gp3"
}

variable "public_instance_name"{
    default = "public_instance "
}

variable "private_instance_name"{
    default = "private_instance"
}
