output "public_ip-1"{
    value = aws_instance.public_instance1.public_ip
}

output "public_ip-2"{
    value = aws_instance.public_instance2.public_ip
}