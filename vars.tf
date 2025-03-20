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

