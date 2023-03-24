# Terraform
```
terraform init
```
> Install the latest module and provider versions allowed within configured constraints, overriding the default behavior of selecting exactly the version recorded in the dependency lockfile.
```
terraform init -upgrade
```
> Reconfigure a backend, ignoring any saved configuration.
```
terraform init -reconfigure
```
> Reconfigure a backend, and attempt to migrate any existing state.
```
terraform init -migrate-state
```

```
terraform apply
terraform apply -auto-approve
```
> Terraform graph
```
terraform graph
dot -Tsvg graph > graph.svg
```