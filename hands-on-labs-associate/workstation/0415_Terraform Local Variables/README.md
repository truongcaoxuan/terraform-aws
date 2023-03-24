# Terraform Locals Block

> Template
```
locals{
    # Blockbody
    local_variable_name = <EXPRESSIONORVALUE>
    local_variable_name = <EXPRESSIONORVALUE>
}
```
> Example
```
locals{
    time        = timestamp()
    application = "api_server"
    server_name = "${var.account}-${local.application}"
}
```