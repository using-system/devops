# Variable

### Define a variable by command line

<details>
<summary>show</summary>
<p>

`terraform plan -var="myvar=myvalue"`

</p>
</details>

### Define a variable with file

<details>
<summary>show</summary>
<p>

`terraform plan -var-file="dev.tfvars"`

</p>
</details>

### Define a variable with env variable

<details>
<summary>show</summary>
<p>

`setx TF_VAR_myvar`

</p>
</details>

### Different types of a variable

<details>
<summary>show</summary>
<p>

 - string (ex `"myvalue""`)
 - number (ex `666`)
 - list (ex `["value1","value2"]`)
 - bool (ex `true`)
 - map (ex `{env = "Dev", project = "Demo"}`)

</p>
</details>

# Syntax

### Define a count for aws users and referer to the index for the name

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_iam_user" "account" {
    count = 3
    name = "user${count.index}"
}
```

</p>
</details>


### Define a instance if var enable_jumpbox is set to true

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_instance" "jumpbox" {
    count = var.enable_jumbox ? 1 : 0
    name = "user${count.index}"
}
```

</p>
</details>

# Functions

### Where is doc of function

<details>
<summary>show</summary>
<p>

[Configuration language> Functions](https://developer.hashicorp.com/terraform/language/functions)

</p>
</details>

### How to test functions in cli

<details>
<summary>show</summary>
<p>

`terraform console`

</p>
</details>

### Compute max/min of 15, 78 , 11

<details>
<summary>show</summary>
<p>

`max(15,78,11)`

`min(15,78,11)`

</p>
</details>

### Split string "value1,value2,value3" by ,

<details>
<summary>show</summary>
<p>

`split(",","value1,value2,value3")`

</p>
</details>

### Get element of a map defined by key a

<details>
<summary>show</summary>
<p>

`lookup({a = "value1", b= "value2"}, "a", "defaultvalue")` --> value1

</p>
</details>


### Retrieve element from a list with index 2

<details>
<summary>show</summary>
<p>

`element(["a", "b", "c"], 2)` --> c

</p>
</details>

### Load a file nammed public_key.pub presents in module path 

<details>
<summary>show</summary>
<p>

`file(${path.module}/public_key.pub)`

</p>
</details>

### Get the current year with the format YYYY

<details>
<summary>show</summary>
<p>

`formatdate("YYYY", timestamp())`

</p>
</details>

# Datasource

### get the most recent aws ami owened by amazon 

<details>
<summary>show</summary>
<p>

```hcl
data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
```
</p>
</details>

# DEBUGGING


### Enable logging in terraform

<details>
<summary>show</summary>
<p>

Set env variable `TF_LOG` to `TRACE` or `DEBUG` or `INFO` or `WARN` or `ERROR`

ex : `export TF_LOG=TRACE`

</p>
</details>


### set logging file path

<details>
<summary>show</summary>
<p>

 `export TF_LOG_PATH=/tmp/tf.log`

</p>
</details>

# Dynamic block

### Where is doc of function

<details>
<summary>show</summary>
<p>

[Configuration language> Expressions> Dynamics blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)

</p>
</details>

### set egress and ingess dynamic blocks for variable sg_ports 

<details>
<summary>show</summary>
<p>

```hcl
resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```
</p>
</details>

# Tainting resources

### Replace resource aws_instance.myvm

<details>
<summary>show</summary>
<p>

 `terraform apply -replace="aws_instance.myvm"`

 instead

  `terraform taint`

</p>
</details>

# Splat expression

### Output the arn of the resource aws_iam_user.users (multiple elements)

<details>
<summary>show</summary>
<p>

```hcl
output "arns" {
    value = aws_iam_user.users[*].arn
}
```
</p>
</details>

### Output the previous output values from state

<details>
<summary>show</summary>
<p>

`terraform output arns`

</p>
</details>