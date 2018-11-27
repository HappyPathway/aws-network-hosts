//--------------------------------------------------------------------
// Variables
variable "resource_tags" {
  type        = "map"
  description = "Resource Tags"
}

variable "vault_policies" {
  type = "list"
  default = ["default"]
}

variable "jenkins_job" {}

variable "vault_addr" {}

variable "env" {}

variable "organization" {}
variable "network_ws" {}
variable "public_instances" {
  default = 0
}

variable "private_intances" {
  default = 2
}

variable "private_instances" {
  default = 2
}

variable "ssh_cidr" {
  default = "0.0.0.0/0"
}
variable "instance_type" {}

//--------------------------------------------------------------------
// Modules

data "template_file" "init" {
  template = "${file("${path.root}/userdata.sh")}"

  vars {
    vault_addr  = "${var.vault_addr}"
    env         = "${var.env}"
    jenkins_job = "${var.jenkins_job}"
  }
}

module "network_host" {
  source        = "github.com/HappyPathway/terraform-aws-network-host"
  version       = "2.2.0"
  user_data     = "${data.template_file.init.rendered}"
  public_instances = "${var.public_instances}"
  private_instances = "${var.private_instances}"
  network_ws    = "${var.network_ws}"
  organization  = "${var.organization}"
  resource_tags = "${var.resource_tags}"
  ssh_cidr = "${var.ssh_cidr}"
  instance_type = "${var.instance_type}"
  env = "${var.env}"
}

output "public_hosts" {
  value = "${module.network_host.public_hosts}"
}
  
output "private_hosts" {
  value = "${module.network_host.private_hosts}"
}

output "private_instances" {
  value = "${module.network_host.private_instances}"
}
  
output "public_instances" {
  value = "${module.network_host.public_instances}"
}

output "key_name" {
  value = "${module.network_host.key_name}"
}
  
 # comment
