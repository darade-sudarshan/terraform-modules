# VPC Module
module "vpc" {
  source = "./modules/vpc"

  environment = "dev"
  vpc_cidr    = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

# Public EC2 Instance
module "public_ec2" {
  source = "./modules/ec2"
  environment      = "dev"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_ids[0]  # First public subnet
  instance_name   = "linux-public-instance"
  key_name        = "your-key-pair-name"  # Replace with your key pair name
  enable_public_ip = true
  allowed_cidr_blocks = ["YOUR_IP/32"]  # Replace with your IP for security
}


module "iam_role" {
  source = "./modules/iam-role"
}

module "autoscaling_group" {
  source               = "./modules/auto-scaling"
  instance_type        = var.instance_type
  vpc_id               = module.vpc.vpc_id
  key_name             = var.key_name
  ami_image_id         = var.linux_ami_id
  lb_sg_id             = module.vpc.lb_sg_id
  subnet_id_1          = module.vpc.subnet_ids[0]
  subnet_id_2          = module.vpc.subnet_ids[1]
  iam_instance_profile = module.iam_role.instance_profile_id
  task_sg_id           = module.vpc.task_sg_id
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}