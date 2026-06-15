## Change project_name to theproject name
project_name = "ml-pipeline-terraform-demo" //project name here
region = "us-west-1" //choose regoin to deploy in another region ie us-east-1 

## Change instance types amd volume size for SageMaker if desired
training_instance_type = "ml.c8g.large"  				//this can be changed but need to request from AWS upgrade to account 
inference_instance_type = "ml.c5.large"
volume_size_sagemaker = 5

## Should not be changed with the current folder structure
handler_path  = "../../src/lambda_function"
handler       = "config_lambda.lambda_handler"

