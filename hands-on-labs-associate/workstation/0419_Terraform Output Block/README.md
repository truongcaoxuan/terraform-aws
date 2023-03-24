# Terraform Output Block

- Outputs are also necessary to share data from a child module to your root module
- Each output name should be unique

> Template
```
output "<NAME>" {
    #Blockbody
    value= <EXPRESSION> #Argument
}
```

> Example
```
output "web_server_ip" {
    description = "Public IP Address of Web Serveron EC2"
    value       = aws_instance.web_server.public_ip
    sensitive   = true
}
```
> Add Output Block to Export Attributes of Resources
```
output "hello-world" {
    description = "Print a Hello World text output"
    value       = "Hello World"
}
output "vpc_id" {
    description = "Output the ID for the primary VPC"
    value       = aws_vpc.vpc.id
}
```

> Output Meaningful Data using Static and Dynamic Values
```
output "public_url"{
    description = "Public URL for our Web Server"
    value       = "https://${aws_instance.web_server.private_ip}:8080/index.html"
}
output "vpc_information"{
description = "VPC Information bout Environment"
value       = "Your ${aws_vpc.vpc.tags.Environment} VPC has an ID of ${aws_vpc
.vpc.id}"
}
```
> View the list of outputs from your configuration:
```
terraform output
terraform output -json
```
