# Terraform Provisioner

> Provisioners
- Provisioners are a Last Resort
- Passing data into virtual machines and other compute resources
- Running configuration management software
- First-class Terraform provider functionality may be available

> How to use Provisioners

```
resource "aws_instance" "web" {
  # ...

  # use provisioners to model specific actions on the local machine
  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
    
    # Destroy-Time Provisioners
    when    = destroy       // run before the resource is destroyed

    # Failure Behavior
    on_failure = continue   // Ignore the error and continue with creation or destruction.
    on_failure = fail       // Raise an error and stop applying (the default behavior). If this is a creation provisioner, taint the resource.
  }

  # use provisioners to model specific actions on remote machine 
  provisioner "remote-exec" {
    command = "echo Hello World"
  }

  

}

```

> Provisioner Connection Settings

Most provisioners require access to the remote resource via SSH or WinRM and expect a nested connection block with details about how to connect.
```
# Copies the file as the root user using SSH
provisioner "file" {
  source      = "conf/myapp.conf"
  destination = "/etc/myapp.conf"

  connection {
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
    host     = "${var.host}"
  }
}
```

> Provisioners Without a Resource

run provisioners that aren't directly associated with a specific resource
```
resource "aws_instance" "cluster" {
  count = 3

  # ...
}

resource "terraform_data" "cluster" {
  # Replacement of any instance of the cluster requires re-provisioning
  triggers_replace = aws_instance.cluster.[*].id

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = aws_instance.cluster.[0].public_ip
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "bootstrap-cluster.sh ${join(" ", aws_instance.cluster.*.private_ip)}",
    ]
  }
}

```


