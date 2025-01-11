# Get latest Amazon Windows AMI
data "aws_ami" "windows-2019" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
}
# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Bootstrapping PowerShell Script
data "template_file" "windows-userdata" {
  template = <<EOF
<powershell>
# Rename Machine
Rename-Computer -NewName "${var.windows_instance_name}" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

# Restart machine
shutdown -r -t 10;
</powershell>
EOF
}

# Bootstrapping PowerShell Script
data "template_file" "linux-userdata" {
  template = <<EOF
<powershell>
# Rename Machine
Rename-Computer -NewName "${var.linux_instance_name}" -Force;

# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

# Restart machine
shutdown -r -t 10;
</powershell>
EOF
}

# Security Group
resource "aws_security_group" "instance_sg" {
  name_prefix = "${var.environment}-instance-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow incoming RDP connections"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow incoming RDP connections"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-instance-sg"
    Environment = var.environment
    owners = "sudarshan.darade@einfochips.com"
  }
}

# Windows EC2 Instance
resource "aws_instance" "windows" {
  ami           = data.aws_ami.windows-2019.id
  instance_type = var.windows_instance_type
  subnet_id     = var.subnet_id
  
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name              = var.key_name

  associate_public_ip_address = var.enable_public_ip
  user_data  = data.template_file.windows-userdata.rendered
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
    delete_on_termination = true
    tags = {
    Name = "OS disk"
    owners = "sudarshan.darade@einfochips.com"
  }
  }
  # attach 10 GB of additional Disk volume
ebs_block_device {
  device_name = "data disk"
  volume_size = 10
  volume_type = "gp3"
  encrypted = true
  delete_on_termination = true
  tags = {
    Name = "data disk"
    owners = "sudarshan.darade@einfochips.com"
  }
}

  tags = {
    Name        = var.windows_instance_name
    Environment = var.environment
    owners = "sudarshan.darade@einfochips.com"
  }
}

# EC2 Instance
resource "aws_instance" "linux" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.linux_instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name              = var.key_name
  associate_public_ip_address = var.enable_public_ip
  user_data  = data.template_file.linux-userdata.rendered
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    encrypted   = true
    delete_on_termination = true
    tags = {
    Name = "OS disk"
    owners = "sudarshan.darade@einfochips.com"
  }
  }
  # attach 10 GB of additional Disk volume
ebs_block_device {
  device_name = "/dev/xvda"
  volume_size = 10
  volume_type = "gp3"
  encrypted = true
  delete_on_termination = true
  tags = {
    Name = "data disk"
    owners = "sudarshan.darade@einfochips.com"
  }
}

  tags = {
    Name        = var.linux_instance_name
    Environment = var.environment
    owners = "sudarshan.darade@einfochips.com"
  }
}
