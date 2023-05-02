module "rg" {
  source            = "../../../modules/azure/rg"

  name              = "my-rg"
  location          = "westeurope"

  tags              = {
    project = "Using-System" 
  }

}