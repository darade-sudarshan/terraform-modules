# VPC Module
module "vpc" {
  source = "/home/einfochips/task/modules/vpc"
  environment = "dev"
  vpc_cidr    = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
}

# Public EC2 Instance
module "public_ec2" {
  source                = "/home/einfochips/task/modules/ec2"
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  subnet_id             = module.vpc.public_subnet_ids[0] # First public subnet
  windows_instance_type = var.windows_instance_type
  key_name              = var.key_name # Replace with your key pair name
  enable_public_ip      = true
  allowed_cidr_blocks   = var.allowed_cidr_blocks # Replace with your IP for security
  count = 1
  windows_instance_name = "var.windows_instance_name-${count.index}"
  linux_instance_name   = "var.linux_instance_name${count.index}"

}
