# Terraform **Backend** Configuration

# #########################################
## Partial backend configuration via a **file**
# #########################################
```
    terraform init -backend-config=state_configuration/dev_local.hcl -migrate-state
    terraform plan
    terraform apply
```

```
    terraform init -backend-config=state_configuration/test_local.hcl -migrate-state
    terraform plan
    terraform apply
```

# #########################################
## Partial backend configuration via **command line**
# #########################################
```
    terraform init -backend-config="path=state_data/terraform.test.tfstate" - migrate-state
    terraform plan
    terraform apply
```

```
    terraform init -backend-config="path=state_data/terraform.dev.tfstate" - migrate-state
    terraform plan
    terraform apply
```

# #########################################
## Partial configuration with a **terraform.tf** and **s3-state.hcl**
# #########################################
```
    terraform init -backend-config="state_configuration/s3-state.hcl" -migrate-state
    terraform plan
    terraform apply
```

# #########################################
## Partial configuration with a **terraform.tf**, **s3-state-bucket.hcl** and **dev-s3-state-key.hcl**
# #########################################
```
    terraform init -backend-config="state_configuration/s3-state-bucket.hcl"\
        -backend-config="state_configuration/dev-s3-state-key.hcl"\
        -migrate-state
    terraform plan
    terraform apply
```