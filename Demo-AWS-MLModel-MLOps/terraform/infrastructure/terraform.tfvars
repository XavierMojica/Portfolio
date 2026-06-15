## Change project_name to the  project name of choice
project_name = "ml-pipeline-terraform-demo" //project name goes here
region       = "us-east-1"                  //change region if need be to deploy in another region

## Change instance types amd volume size for SageMaker if desired
training_instance_type  ="ml.c8g.large" 											//ml.m5.xlarge
inference_instance_type = "ml.c5.large"
volume_size_sagemaker   = 5

## Should not be changed with the current folder structure
##Tells Terraform where the AWS Lambda code is located and which Python fn Lambda should run first
handler_path = "../../src/lambda_function"    //folder path to your Lambda source code
handler      = "config_lambda.lambda_handler" //This tells AWS Lambda: Run the function named lambda_handler inside the file config_lambda.py

