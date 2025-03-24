variable "AWS_region" {
  type = string
}

variable "subnet_zones" {
  type = list(string)
}

variable "ssh_access" {
  type = bool
}

variable "vpc_cidr" {
    type = string
}

variable "egress_rules" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = list(string)
}))
}

variable "ingress_rules" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = list(string)
}))
}