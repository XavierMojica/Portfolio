# Configure Terraform and required providers
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "MultiCloud-Demo"
      ManagedBy   = "Terraform"
    }
  }
}

# Configure Azure Provider
provider "azurerm" {
  features {}
}

# AWS VPC and Networking
resource "aws_vpc" "main" {
  cidr_block           = "YOUR_IP/16"                                               #update to appropriate cidre block 
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "multicloud-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "YOUR_IP/24"                                          #update 
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "multicloud-public-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "multicloud-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "YOUR_IP/0"                                            #update
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "multicloud-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# AWS Security Group
resource "aws_security_group" "web" {
  name        = "multicloud-web-sg"
  description = "Security group for web server"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/0"]                                   #update
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/0"]                                 #update
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/0"]                               #update
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["YOUR_IP/0"]                                 #update
  }

  tags = {
    Name = "multicloud-web-sg"
  }
}

# AWS Key Pair
resource "aws_key_pair" "main" {
  key_name   = "multicloud-key"
  public_key = var.aws_public_key
}

# AWS EC2 Instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.aws_instance_type
  key_name               = "keypair-name"                                                           #entire KEY NAME HERE
  vpc_security_group_ids = [aws_security_group.web.id]
  subnet_id              = aws_subnet.public.id

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from AWS EC2!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "multicloud-aws-web"
  }
}

# Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "multicloud-rg"
  location = var.azure_location

  tags = {
    Environment = var.environment
    Project     = "MultiCloud-Demo"
    ManagedBy   = "Terraform"
  }
}

# Azure Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "multicloud-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = var.environment
  }
}

# Azure Subnet
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  address_prefixes     = ["10.1.2.0/24"]
}
                                                                  #virtual_network_name = azurerm_virtual_network.main.name was above in line 177 but DO NOT USE

# Azure Public IP
resource "azurerm_public_ip" "main" {
  name                = "multicloud-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"                                                            #this was added

  tags = {
    Environment = var.environment
  }
}

# Azure Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "multicloud-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environment
  }
}

# Azure Network Interface
resource "azurerm_network_interface" "main" {
  name                = "multicloud-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

  tags = {
    Environment = var.environment
  }
}

# Associate Network Security Group to Network Interface
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Azure Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  name                = "multicloud-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.azure_vm_size
  admin_username      = "adminuser"

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.azure_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello from Azure VM!</h1>" > /var/www/html/index.html
              EOF
  )

  tags = {
    Environment = var.environment
  }
}
