variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be created"
  type        = string
}

variable "windows_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "linux_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "windows_instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
variable "linux_instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "enable_public_ip" {
  description = "Whether to enable public IP for the instance"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the instance"
  type        = list(string)
  
}

