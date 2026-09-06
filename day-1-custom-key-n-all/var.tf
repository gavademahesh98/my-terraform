variable "ami"{
    default = "ami-0532913178263be11"
}

variable "instance_type"{
    default = "t3.micro"

}

variable "user_data_file"{
     default = "/root/my-terraform/day-1-custom-key-n-all/user_data.sh"
}


variable "public_key_path"{
    default = "/root/.ssh/id_ed25519.pub"
}

variable "key_name"{
    default = "my-keypair"
}


variable "instance_name" {
    default = "My-Ec2-Nginx-Instance"
}