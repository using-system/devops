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