variable "ami"{
    default = "ami-0532913178263be11"

}

variable "instance_type"{
    default = "t3.micro"

}

variable "key_name"{
    default = "key-singapore"

}

variable "instance_name"{
    default = "My-NGINX-Instance"
}

variable "file_path"{
    default = "/root/my-terraform/day-1-userdata-output/user_data.sh"
}