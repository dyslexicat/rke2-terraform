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

variable "lb_ports" {
  type = map(number)
  default = {
    6443 = 6443
    9345 = 9345
  }
}

variable "master_count" {
  description = "Number of EC2 instances for master nodes"
  type = number
  default = 1
}

variable "worker_count" {
  description = "Number of EC2 instances for worker nodes"
  type = number
  default = 3
}
