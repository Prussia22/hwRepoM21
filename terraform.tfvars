#This file has example values for each of the variables, and can be used as a template to create a custom .tfvars file
AWS_region = "us-east-1"

subnet_zones = [ 
    "us-east-1a", 
    "us-east-1b"
]

vpc_cidr = "10.0.0.0/16"

ssh_access = true

#Egress and ingress rules to open ssh port for IPs in the VPC
/*
egress_rules = [{
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/16" ]
}]

ingress_rules = [{
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/16" ]
}]
*/

#Egress and ingress rules to open SSH and HTTP ports to IPs in the VPC
egress_rules = [{
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/16" ]
},
{
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/16" ]
}
]
ingress_rules = [{
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/16" ]
},
{
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "10.0.0.0/16" ]
}
]


#Do not produce any ingress or egress rules
/*
egress_rules  = null
ingress_rules = null
*/