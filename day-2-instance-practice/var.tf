variable "ami"{
    default = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type"{
    default = "t3.micro"
}

variable "key_name"{
    default = "instance_key"
}

variable "public_key_path"{
   default = "/root/.ssh/id_ed25519.pub"
}

variable "user_data_file"{

    default = "/root/my-terraform/day-2-instance-practice/userdata.sh"
}

variable "instance_name"{
    default = "my-nginx-instance"
}