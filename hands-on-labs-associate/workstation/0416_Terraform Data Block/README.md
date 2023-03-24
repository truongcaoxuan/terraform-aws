# Terraform Data Block
> Template
```
data "<DATA TYPE>" "<DATA LOCAL NAME>" {
    #Blockbody
    <IDENTIFIER> = <EXPRESSION> #Argument
}
```
> Example
```
# Retrieve the AWS region
data "aws_region" "current"{ }

# Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}

#Terraform Data Block-Lookup Ubuntu 16.04
data "aws_ami" "ubuntu_16_04" {
    most_recent= true
    filter{
        name="name"
        values= ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }
    owners= ["099720109477"]
}
```

> Syntax to refer to a data block 
```
data.<type>.<name>.<attribute>
```
