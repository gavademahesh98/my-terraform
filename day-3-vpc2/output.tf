output "public_ip_public"{
    value = aws_instance.public_instance.public_ip

}

output "private_ip_public"{
    value = aws_instance.public_instance.private_ip

}

output "private_ip_private"{
    value = aws_instance.private_instance.private_ip
    
}