# AWS Outputs
output "aws_instance_id" {
  description = "ID of the AWS EC2 instance"
  value       = aws_instance.web.id
}

output "aws_instance_public_ip" {
  description = "Public IP address of the AWS EC2 instance"
  value       = aws_instance.web.public_ip
}

output "aws_instance_public_dns" {
  description = "Public DNS name of the AWS EC2 instance"
  value       = aws_instance.web.public_dns
}

# Azure Outputs
output "azure_vm_id" {
  description = "ID of the Azure VM"
  value       = azurerm_linux_virtual_machine.main.id
}

output "azure_vm_public_ip" {
  description = "Public IP address of the Azure VM"
  value       = azurerm_public_ip.main.ip_address
}

output "azure_resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.main.name
}
