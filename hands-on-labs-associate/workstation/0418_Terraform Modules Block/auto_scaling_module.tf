module "autoscaling" {
  # use source module from Terraform Public Registry
  #  source  = "terraform-aws-modules/autoscaling/aws"
  #  version = "6.9.0"

  # use source module from Github
  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling?ref=v6.9.0"

  #Autoscalinggroup
  name = "myasg-module"
  vpc_zone_identifier = [aws_subnet.res_privates["private_subnet_1"].id,
    aws_subnet.res_privates["private_subnet_2"].id,
  aws_subnet.res_privates["private_subnet_3"].id]
  min_size         = 0
  max_size         = 1
  desired_capacity = 1
  #Launchtemplate
  #use_lt    = true
  create_launch_template = true

  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "EC2 Web Server Autoscaling"
  }

}

