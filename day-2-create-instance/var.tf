variable "key_name"{
    default = "yogesh_key"
}

variable "public_key_path"{
    default = "/root/.ssh/id_ed25519.pub"
}

variable "ami"{
    default  = "ami-0532913178263be11"
}

variable "instance_type"{
    default = "t3.micro"

}

variable "script_path"{
    default = "/root/my-terraform/day-2-create-instance/script.sh"
}