# About

Devops stuffs about terraform, k8s, azure...

# Terraform modules

Secure, tested, documented and free to use (by refer the modules or copy them for your projects !)

## Link

[Source](https://github.com/using-system/devops/tree/main/terraform/modules)

[CI workflow](https://github.com/using-system/devops/actions/workflows/tf-modules-validation.yml)

## Features

  - Azure, Kubernetes and helm modules
  - All modules are tested with last version of terraform and providers
  - Checked with [checkov](https://www.checkov.io)
  - Tested with terraform test framework (terraform test)
  - Documentation generated for each module (with [terraform-docs](https://terraform-docs.io/))

## Integration

### By commit ref

*(sample for commit ref 8d898691b4001e0fe5de3c97d7c7fe2183adb70a and module az-iam)*

```
module "dns_zone_vnet_link_blob" {

  source = "git::https://github.com/using-system/devops.git//terraform/modules/az-iam?ref=8d898691b4001e0fe5de3c97d7c7fe2183adb70a"

}
```


### By release tag

*(sample for commit release 1.1.0 and module az-iam)*

```
module "dns_zone_vnet_link_blob" {

  source = "git::https://github.com/using-system/devops.git//terraform/modules/az-iam?ref=1.1.0"

}
```

# Github actions

## checkov

[Link](https://github.com/using-system/devops/tree/main/github/actions/checkov)

## gh-comment-current-issue

[Link](https://github.com/using-system/devops/tree/main/github/actions/gh-comment-current-issue)

## terrascan

[Link](https://github.com/using-system/devops/tree/main/github/actions/terrascan)

# Kubernetes certification preparation

## CKA

[Link](https://github.com/using-system/devops/tree/main/k8s/cka)


## CKS

[Link](https://github.com/using-system/devops/tree/main/k8s/cks)