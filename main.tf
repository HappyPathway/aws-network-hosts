//--------------------------------------------------------------------
// Variables
variable "resource_tags" {}

//--------------------------------------------------------------------
// Modules
module "network_host" {
  source  = "app.terraform.io/Darnold-Hashicorp/network-host/aws"
  version = "1.2.0"

  count = 2
  network_ws = "DemoNetwork-East"
  organization = "Darnold-Hashicorp"
  resource_tags = "${var.resource_tags}"
}
