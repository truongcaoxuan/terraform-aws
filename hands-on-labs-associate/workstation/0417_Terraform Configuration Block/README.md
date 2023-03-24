# Terraform Configuration Block

> Example

Define a minimum version of Terraform to be used
```
terraform{
    required_version = ">=0.15.0"
}
```
> Terraform version constraints

required_version = "0.15.0"
  
  - Only Terraform v0.15.0 exactly
  - To upgrade Terraform, first edit the required_version setting

required_version = ">=0.15.0"
  
  - Any Terraform v0.15.0 or greater
  - Includes Terraform v1.0.0 and above

required_version = "~>0.15.0"
  
  - Any Terraform v0.15.x, but not v1.0 or later
  - Minor version updates are intended to be non-disruptive

required_version = ">= 0.15.0, < 2.0.0"
  
  - Terraform v0.15.0 or greater, but less than v2.0.0
  - Avoids major version updates


> Check Terraform version
```
terraform -version
```
