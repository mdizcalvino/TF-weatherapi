variable "arm_client_secret" {
    type = string
    default = "c65_dS7.4c~EP~.QyiWh3c.Z7R~2ATZ181"
}
variable "arm_client_id" {
    type = string
    default = "a6c7b950-e25d-4ef5-97b1-3a93128ed940"

}
variable "arm_tenant_id" {
    type = string
    default = "cbd93983-61b7-4cf4-ba68-31f4b073319f"  
}
variable "arm_subscription_id" {
    type = string
    default = "b07a0e2c-babf-400a-b1d2-1d6163872541"
  
}

variable "imagebuild" {
    type = string 
    desdescription = "Latest Image Build"   
}


provider "azurerm" {
    version = "2.5.0"
    features{}
  
}

terraform {
    backend "azurerm" {
        resource_group_name = "rg-TF-storage"
        storage_account_name = "sttfmdc"
        container_name = "tfstate"
        key = "terraform.tfstate"
      
    }
  
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "West Europe"  
}

resource  "azurerm_container_group" "tfcg_test" {
   name = "weatherapi"
   location = azurerm_resource_group.tf_test.location
   resource_group_name = azurerm_resource_group.tf_test.name

   ip_address_type = "public"
   dns_name_label = "binarythistlwa"
   os_type ="linux"

   container {
       name = "weatherapi"
       image = "maemedocker/weatherapi:${var.imagebuild}"
       cpu = "1"
       memory = "1"

       ports {
           port = 80
           protocol = "TCP"
       }
   }
}