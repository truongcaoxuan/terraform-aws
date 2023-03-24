
provider "aws" {
  region = "us-west-2"
}

provider "random" {}

resource "random_pet" "name" {}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  user_data     = file("init-script.sh")

  tags = {
    NameVar = var.instance_name
    NameRandom = random_pet.name.id

  }
}