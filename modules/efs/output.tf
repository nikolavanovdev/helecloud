output "efs_url" {
  value = aws_efs_file_system.efs.dns_name
}

output "mount_target_ip" {
  value = aws_efs_mount_target.efs_mount_target.ip_address
}