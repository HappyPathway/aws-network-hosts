data "aws_caller_identity" "current" {}

data "terraform_remote_state" "network" {
  backend = "atlas"

  config {
    name = "${var.organization}/${var.network_ws}"
  }
}

resource "vault_aws_auth_backend_role" "admin" {
  backend                        = "aws"
  role                           = "${module.network_host.role}"
  auth_type                      = "iam"
  bound_account_id               = "${data.aws_caller_identity.current.account_id}"
  bound_iam_role_arn             = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${module.network_host.role}"
  bound_iam_instance_profile_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/${module.network_host.role}"
  inferred_entity_type           = "ec2_instance"
  inferred_aws_region            = "${data.terraform_remote_state.network.region}"
  ttl                            = 60
  max_ttl                        = 120
  policies                       = "${var.vault_policies}"
}
