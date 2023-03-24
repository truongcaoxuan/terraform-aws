# Terraform Taint and Replace

## Terraform Taint

> Get correct ID for the resource you want to taint
```
terraform state list
```

> Mark the webserver to be recreated with the taint command
```
terraform taint aws_instance.web_server
```

> Recreate the Web Server
```
terraform plan
terraform apply
```

> Observe a remote-exec provisoner failing, resulting in Terraform automatically tainting a resource. *This informs Terraform that this resource needs to be rebuilt upon the next terraform*
apply.
```
terraform state show aws_instance.web_server
```
> Untaint a resource. *This informs Terraform that this resource does not need to be rebuilt upon the next terraform apply.*
```
terraform untaint aws_instance.web_server
```
## Terraform replace

> Use the -replace option rather than taint
- As of Terraform v0.15.2 and later the taint command is deprecated, because there are better alternatives
available.
- If your intent is to force replacement of a particular object even though there are no configuration
changes that would require it, it is recommended to use the -replace option with terraform apply in
place of the depcreated taint command.

```
terraform apply -replace="aws_instance.web_server"
```
- Using the -replace command to rebuild a resource is the recommended approach moving forward.
