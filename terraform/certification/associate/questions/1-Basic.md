# Credentials Configuration

### Configure user access key crendentials

<details>
<summary>show</summary>
<p>

`aws configure`

</p>
</details>

# SSO Configuration

### Configure sso command

<details>
<summary>show</summary>
<p>

`aws configure sso`

</p>
</details>

### Set profile in powershell

<details>
<summary>show</summary>
<p>

`$Env:AWS_PROFILE = "MyProfile"`

</p>
</details>

### SSO login command

<details>
<summary>show</summary>
<p>

`aws sso login`

</p>
</details>

# Providers

### Differents providers types

<details>
<summary>show</summary>
<p>

 - Official (Owned and maintained by HashiCorp)
 - Partner
 - Community

</p>
</details>

### Refers a non-hashicorp maintained provider

<details>
<summary>show</summary>
<p>

```hcl
terraform
{
    required_providers{
        digitalocean = {
            source= "digitalocean/digitalocean"
        }
    }
}

provider "digitalocean" {
    token = "mytoken"
}
```

</p>
</details>

### Specify provider version greater or equal to 1.0

<details>
<summary>show</summary>
<p>

`>=1.0`

</p>
</details>

### Specify provider version less than equal to 1.0

<details>
<summary>show</summary>
<p>

`<=1.0`

</p>
</details>

### Specify provider version any version in range 1.X

<details>
<summary>show</summary>
<p>

`~>1.0`

</p>
</details>

### Specify provider version between 1.15 and 1.30

<details>
<summary>show</summary>
<p>

`>=1.15,<=1.30`

</p>
</details>

### Specify terraform version higher than 0.15 and aws provider in range 2.X
<details>
<summary>show</summary>
<p>

```hcl
terraform {
  required_version = "< 0.11"
  required_providers {
    aws = "~> 2.0"
  }
}
```

</p>
</details>

# State

### Name of the local state file

<details>
<summary>show</summary>
<p>

`terraform.tfstate`

</p>
</details>

### Ignore change on tags resource
<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
    ami = "ami-0f34c5ae932e6f0e4"
    instance_type = "t2.small"

    tags = {
        Name = "UsingSystem"
    }

    lifecycle {
        ignore_changes = [tags]
    }
}
```

</p>
</details>

### Ingore all changes on a resource
<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
    ami = "ami-0f34c5ae932e6f0e4"
    instance_type = "t2.small"

    tags = {
        Name = "UsingSystem"
    }

    lifecycle {
        ignore_changes = all
    }
}
```

</p>
</details>

### Syntax to create new resource before remove the oldest

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
    ami = "ami-0f34c5ae932e6f0e4"
    instance_type = "t2.small"

    tags = {
        Name = "UsingSystem"
    }

    lifecycle {
        create_before_destroy = true
    }
}
```

</p>
</details>

### Syntax to forbiden removing of a resource

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
    ami = "ami-0f34c5ae932e6f0e4"
    instance_type = "t2.small"

    tags = {
        Name = "UsingSystem"
    }

    lifecycle {
        prevent_destroy  = true
    }
}
```

</p>
</details>

# Cli

### Command for destroy

<details>
<summary>show</summary>
<p>

`terraform destroy`

</p>
</details>

### Command for destroy with target

<details>
<summary>show</summary>
<p>

`terraform destroy -target aws_instance.myec2`

</p>
</details>

### Command for check syntax format

<details>
<summary>show</summary>
<p>

`terraform fmt`

</p>
</details>

### Command for validate terraform files

<details>
<summary>show</summary>
<p>

`terraform validate`

</p>
</details>

### Commands for svg graph
<details>
<summary>show</summary>
<p>

`terraform graph > graph.dot`

`yum install graphviz`

`cat graph.dot | dot -Tsvg > mygraph.svg`

</p>
</details>

### Commands for save plan to a file and apply it
<details>
<summary>show</summary>
<p>

`terraform plan -out=tfplan`

`terraform apply tfplan`

</p>
</details>

### Commands for plan without refresh the state and targetting resource aws_security_group.mygroup
<details>
<summary>show</summary>
<p>

`terraform plan -refresh=false`

`terraform plan -refresh=false -target=aws_security_group.mygroup`

</p>
</details>

# Provisionners

### Where is doc of provisionners

<details>
<summary>show</summary>
<p>

[Configuration language> Resources> Provisionners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

</p>
</details>

### Different types of provisionners

<details>
<summary>show</summary>
<p>

 - local-exec
 - remote-exec

</p>
</details>

### How to execute command via shh

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
   //...

   connection {
   type     = "ssh"
   user     = "ec2-user"
   private_key = file("./terraform-key.pem")
   host     = self.public_ip
    }

 provisioner "remote-exec" {
   inline = [
    # Updating with the latest command for Amazon Linux machine
     "sudo yum install -y nginx",
     "sudo systemctl start nginx"
   ]
 }
}
```

</p>
</details>

### How to execute command on local workstation

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
   //...

   provisioner "local-exec" {
    command = "echo 'helloworld'"
  }
}
```

</p>
</details>

### How to execute command on destroy

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
   //...

   provisioner "local-exec" {
    when    = destroy
    command = "echo 'helloworld'"
  }
}
```

</p>
</details>

### When the provisionner is called

<details>
<summary>show</summary>
<p>

On creation, destroy, not update.

</p>
</details>

### How to specify to continue on error

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "myvm" {
   //...

   provisioner "local-exec" {
    on_failure = continue
    command = "echo 'helloworld'"
  }
}
```

</p>
</details>

### How to associate provisionner without resource

<details>
<summary>show</summary>
<p>

```hcl
resource "null_resource" "check" {
   //...

   provisioner "local-exec" {
    command = "curl https://google.com"
  }
}
```

</p>
</details>