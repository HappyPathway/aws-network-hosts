//--------------------------------------------------------------------
// Variables
variable "resource_tags" {
  type        = "map"
  description = "Resource Tags"
}

variable "count" {
  default = 1
}

//--------------------------------------------------------------------
// Modules
module "network_host" {
  source        = "app.terraform.io/Darnold-Hashicorp/network-host/aws"
  version       = "1.3.5"
  user_data     = "${file("${path.root}/userdata.sh")}"
  count         = "${var.count}"
  network_ws    = "DemoNetwork-East"
  organization  = "Darnold-Hashicorp"
  resource_tags = "${var.resource_tags}"
}

output "hosts" {
  value = "${module.network_host.hosts}"
}

output "sec_group" {
  value = "${module.network_host.sec_group}"
}

output "instances" {
  value = "${module.network_host.instances}"
}

output "key_name" {
  value = "${module.network_host.key_name}"
}
