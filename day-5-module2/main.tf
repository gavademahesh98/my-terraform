module "vpc" {
    source = "./module/vpc"
    vpc_cidr = "10.0.0.0./16"
    vpc_name= "dev-vpc"
    public_sub_cidr= "10.0.16.0/20"
    public_sub_az= "ap-southeast-1a"
    private_sub_cidr= "10.0.32.0/20"
    private_sub_az= "ap-southeast-1b"
    igw_name= "dev-igw"
    eip_name= "dev-eip"
    nat_name= "dev-nat"
    sg_name= "dev-sg"
    ssh_port= 22
    http_port= 80

}

module "ec2"{
    source = "./module/ec2"
    key_name= "Yoguram"
    pub_key_path= "/root/.ssh/id_ed25519.pub"
    ami= "ami-0532913178263be11"
    instance_type= "t3.micro"
    pub_instance_name= "dev-public-instance"
    pvt_instance_name= "dev-private-instance"
    pub_sub_id= module.vpc.public_subnet_id
    sg_id= module.vpc.security_group_id
    pvt_sub_id=module.vpc.private_subnet_id
    volume_size= 15
    volume_type= "gp3"
}