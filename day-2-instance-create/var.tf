variable "ami"{
  default = "ami-0532913178263be11"
}

variable "instance_type" {
   default = "t3.micro"
}

variable "key_name"{
   default = "classic-key"
}

variable "public_key_path"{
    default = "/root/.ssh/id_ed25519.pub"

}

variable "user_data_file"{
   default = "/root/my-terraform/day-2-instance-create/userdata.sh"
}

variable "instance_name"{
     default = "my_instance"
}