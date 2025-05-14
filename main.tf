data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-8.5.98-3-r05-linux-debian-11-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  subnet_id = "subnet-02979c360edee0ea5"
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
    kms_key_id  = "alias/aws/ebs"
  }
  tags = {
    Name = "HelloWorld"
  }
}
