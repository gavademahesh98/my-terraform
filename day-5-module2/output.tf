output "public_ip" {
    value = module.ec2.public_ip_public
}
output "private_ip" {
    value = module.ec2.private_ip_private
}