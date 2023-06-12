output "Instance_Public_IP" {
  value = aws_instance.demo_ec2.public_ip
  sensitive = true
} 