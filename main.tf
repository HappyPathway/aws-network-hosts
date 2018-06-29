//--------------------------------------------------------------------
// Variables
variable "resource_tags" {
  type        = "map"
  description = "Resource Tags"
}

//--------------------------------------------------------------------
// Modules
module "network_host" {
  source  = "app.terraform.io/Darnold-Hashicorp/network-host/aws"
  version = "1.2.2"

  count         = 2
  network_ws    = "DemoNetwork-East"
  organization  = "Darnold-Hashicorp"
  resource_tags = "${var.resource_tags}"
}
