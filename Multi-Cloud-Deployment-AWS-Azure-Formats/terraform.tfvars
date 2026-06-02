aws_region        = "us-east-1"																#make sure this is same across 
azure_location    = "East US"																#make sure this is same across
environment       = "dev"
aws_instance_type = "t3.micro"
azure_vm_size     = "Standard_B1s"

# Replace with your actual public keys
aws_public_key   = "ssh-rsa REPLACE_WITH_YOUR_AWS_PUBLIC_KEY"
azure_public_key = "ssh-rsa REPLACE_WITH_YOUR_AWS_PUBLIC_KEY"	             	# its a very long public key that is in Azure after you create Vm
