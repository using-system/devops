# Integrate UsingSystem terraform modules

## By commit ref

*(sample for commit ref 8d898691b4001e0fe5de3c97d7c7fe2183adb70a and module az-iam)*

```
module "dns_zone_vnet_link_blob" {

  source = "git::https://github.com/using-system/devops.git//terraform/modules/az-iam?ref=8d898691b4001e0fe5de3c97d7c7fe2183adb70a"

}
```


## By release tag

*(sample for commit release 1.1.0 and module az-iam)*

```
module "dns_zone_vnet_link_blob" {

  source = "git::https://github.com/using-system/devops.git//terraform/modules/az-iam?ref=1.1.0"

}
```