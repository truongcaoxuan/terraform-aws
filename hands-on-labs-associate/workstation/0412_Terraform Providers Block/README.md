# Configure Terraform AWS Provider

> Task 1: Check Terraform AWS provider version
```
terraform -version
```

> Task 2: Configure Terraform AWS Provider

>> Static credentials
```
    provider"aws"{
        region="us-east-1"
        access_key="my-access-key"
        secret_key="my-secret-key"
    }
```

>> Environment variables
```
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_DEFAULT_REGION="us-east-1"
```

>> Shared credentials/configuration file

The default location is
$HOME/.aws/credentials on Linux and macOS, or "%USERPROFILE%\.aws\credentials" on
Windows. 
```
    provider"aws"{
        region="us-east-1"
        shared_credentials_file="/Users/tf_user/.aws/creds"
        profile="customprofile"
}
```
You can optionally specify a different location in the Terraform configuration by providing the *shared_credentials_file* argument or using the AWS_SHARED_CREDENTIALS_FILE environment
variable. 
This method also supports a *profile* configuration and matching AWS_PROFILE environment
variable.