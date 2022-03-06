AKS cluster with terraform

# Prerequisites

# Install

```
terraform plan -var-file=testing.tfvars -out=tfplan
terraform apply tfplan
```

# Uninstall

```
terraform plan -destroy -var-file=testing.tfvars -out=tfplan
terraform apply tfplan
```

# Example of configuration (tfvars)

```dockerfile
#------------------------------------------------------------------------------
# Global variable
#------------------------------------------------------------------------------

tenant_id               = "***"
subscription_id         = "***"
location                = "westeurope"
naming                  = "usingsystemio-aksdemo"


tags = {
    project             = "PrivateAksCluster"
    env                 = "DEV" 
}

#------------------------------------------------------------------------------
# Monitor
#------------------------------------------------------------------------------

monitor_configuration    = {
    sku                            = "PerGB2018"
    retention_in_days              = 30
}

#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------

network_configuration    = {
    address_spaces                = ["20.105.45.0/24"]
    k8s_sbunet_name               = "K8sSubnet"
    subnets                       = [
            {
                name                                                = "K8sSubnet"
                address_prefixes                                    = ["20.105.45.0/25"] 
                service_endpoints                                   = ["Microsoft.Storage"]
                enforce_private_link_service_network_policies       = true
                enforce_private_link_endpoint_network_policies      = true
            }
        ]
}

#------------------------------------------------------------------------------
# AKS
#------------------------------------------------------------------------------

aks_configuration    = {
    version         = "1.22.4"
    sku             = "Paid"
    private_cluster = true
    admin_username  = "cct_admin"
    admin_ssh_key   = "ssh-rsa ****"
    node_pool       = {
        type                        = "VirtualMachineScaleSets"
        count                       = 3
        vm_size                     = "Standard_B2s"
        availability_zones          = [1, 2, 3]
        os_disk_type                = "Managed"
        os_disk_size                = 128
    }
    addon = {
        enable_open_service_mesh    = true
        enable_azure_policy         = true
    }
}
```

