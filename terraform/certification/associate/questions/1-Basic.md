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

### Commands for savez plan to a file and apply it
<details>
<summary>show</summary>
<p>

`terraform plan -out=tfplan`

`terraform apply tfplan`

</p>
</details>