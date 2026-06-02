variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"                                                               #check this 
}

variable "azure_location" {
  description = "Azure location"
  type        = string
  default     = "East US"                                                                    #check this  
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "aws_instance_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "azure_vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B2s"                                                              #need to check which vm sizes are avaible or will cause issues 
}

variable "aws_public_key" {
  description = "Public key for AWS EC2 instance"
  type        = string
}

variable "azure_public_key" {
  description = "Public key for Azure VM"
  type        = string
}
