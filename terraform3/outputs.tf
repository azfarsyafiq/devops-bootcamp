output "server_ip_private" {
  value = module.my_server_private.private_ip
}

output "ssm_command_private" {
  value = "aws ssm start-session --target ${module.my_server_private.id}"
}