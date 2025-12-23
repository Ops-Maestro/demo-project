output "public_ip" {
  value = aws_instance.web_server.public_ip
}

output "key_file" {
  value = "web-server-key.pem"
}

output "ssh_command" {
  description = "SSH command"
  value       = "ssh -i web-server-key.pem ubuntu@${aws_instance.web_server.public_ip}"
}

output "private_key_file" {
  description = "Private key file"
  value       = "web-server-key.pem"
}