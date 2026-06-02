# Multi-Cloud Infrastructure with Terraform: AWS + Azure

This project uses Terraform to provision a basic multi-cloud infrastructure environment across **AWS** and **Microsoft Azure**. It creates networking, security, compute resources, and public access outputs for both cloud platforms.

## Project Overview

The goal of this project is to demonstrate how Terraform can be used to manage infrastructure as code across multiple cloud providers from one configuration.

This deployment includes:

- AWS VPC
- AWS public subnet
- AWS internet gateway
- AWS route table and route table association
- AWS security group
- AWS EC2 instance running Apache HTTP Server
- Azure resource group
- Azure virtual network
- Azure subnet
- Azure public IP address
- Azure network security group
- Azure network interface
- Azure Linux virtual machine running NGINX

## Repository Structure

```text
.
├── main.tf                    # Main infrastructure resources for AWS and Azure
├── data.tf                    # AWS data sources for availability zones and AMI lookup
├── vars.tf                    # Input variable definitions
├── outputs.tf                 # Terraform output values
├── terraform.tfvars.example   # Example variable values; do not commit real secrets
├── .gitignore                 # Files and folders excluded from Git
└── README.md                  # Project documentation
```

## Technologies Used

- Terraform
- AWS Provider
- AzureRM Provider
- AWS EC2
- AWS VPC
- Azure Virtual Network
- Azure Linux Virtual Machine
- Apache HTTP Server
- NGINX

## Prerequisites

Before running this project, install and configure the following:

1. Terraform 1.0 or newer
2. AWS CLI
3. Azure CLI
4. An AWS account
5. An Azure account
6. SSH key pairs for AWS and Azure VM access

Verify Terraform is installed:

```bash
terraform version
```

Verify AWS authentication:

```bash
aws sts get-caller-identity
```

Verify Azure authentication:

```bash
az account show
```

If needed, log in to Azure:

```bash
az login
```

## Configuration

Create a local `terraform.tfvars` file using the example file as a template.

```bash
cp terraform.tfvars.example terraform.tfvars
```

Example variable values:

```hcl
aws_region        = "us-east-1"
azure_location    = "East US"
environment       = "dev"
aws_instance_type = "t3.micro"
azure_vm_size     = "Standard_B1s"

aws_public_key   = "ssh-rsa REPLACE_WITH_YOUR_AWS_PUBLIC_KEY"
azure_public_key = "ssh-rsa REPLACE_WITH_YOUR_AZURE_PUBLIC_KEY"
```

Do not commit your real `terraform.tfvars` file to GitHub.

## Important Notes Before Deployment

Update placeholder CIDR values in `main.tf` before running Terraform.

For example, use private CIDR ranges for AWS networking:

```hcl
cidr_block = "10.0.0.0/16"
```

```hcl
cidr_block = "10.0.1.0/24"
```

For public internet routing, use:

```hcl
cidr_block = "0.0.0.0/0"
```

For SSH access, avoid allowing SSH from the entire internet in production. Instead of this:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

Use your own public IP address:

```hcl
cidr_blocks = ["YOUR_PUBLIC_IP/32"]
```

Also confirm that the selected Azure VM size is available in your Azure region.

## Deployment Steps

Initialize Terraform:

```bash
terraform init
```

Format the Terraform files:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Preview the infrastructure changes:

```bash
terraform plan
```

Apply the configuration:

```bash
terraform apply
```

Approve the deployment when prompted:

```text
yes
```

## Outputs

After deployment, Terraform displays output values including:

- AWS EC2 instance ID
- AWS EC2 public IP address
- AWS EC2 public DNS name
- Azure VM ID
- Azure VM public IP address
- Azure resource group name

You can also view outputs manually:

```bash
terraform output
```

## Testing the Deployment

After Terraform finishes, open the AWS EC2 public IP in a browser. You should see:

```text
Hello from AWS EC2!
```

Open the Azure VM public IP in a browser. You should see:

```text
Hello from Azure VM!
```

## Destroying Resources

To avoid cloud charges, destroy the resources when finished:

```bash
terraform destroy
```

Approve the destroy operation when prompted:

```text
yes
```

## Security Best Practices

Do not commit the following files or values to a public GitHub repository:

- `terraform.tfvars` with real values
- Terraform state files
- Private keys such as `.pem` or `.key` files
- AWS access keys
- Azure client secrets
- Real SSH private keys
- Passwords or tokens

Recommended `.gitignore`:

```gitignore
# Terraform local files
.terraform/
.terraform.lock.hcl

# Terraform state files
terraform.tfstate
terraform.tfstate.*

# Terraform variable files with real values
terraform.tfvars
*.tfvars
*.tfvars.json

# Crash logs
crash.log
crash.*.log

# Override files
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Private keys
*.pem
*.key
id_rsa
id_rsa.pub
```

## Recommended Improvements

Potential future improvements include:

- Add a variable for allowed SSH CIDR access
- Replace hardcoded AWS key pair names with variables
- Add Azure Network Security Group rules for HTTPS
- Add private subnets and NAT gateways
- Add remote backend storage for Terraform state
- Add modules for reusable AWS and Azure infrastructure
- Add CI/CD validation using GitHub Actions

## Disclaimer

This project is intended for learning and demonstration purposes. Review cloud costs, security rules, region availability, and access controls before deploying to a production environment.
