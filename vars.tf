variable "key_name" {
  description = "ssh key name"
  type = string
  sensitive = true
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR Block"
  type = string
  default = "12.0.1.0/24"
}

variable "ami_name" {
  description = "AMI string for your choice of OS"
  type = string
  default = "ami-05f7491af5eef733a"
}

variable "instance_type" {
  description = "Instance type for EC2 machines"
  type = string
  default = "t2.medium"
}
