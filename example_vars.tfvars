#This file has example values for each of the variables, and can be used as a template to create a custom .tfvars file
AWS_region = "us-east-1"

subnet_zones = [ 
    "us-east-1a", 
    "us-east-1b"
]

vpc_cidr = "10.0.0.0/16"

ssh_access = true