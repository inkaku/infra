variable "admin_users" {}

variable "member_users" {}

provider "github" {
  organization = "inkaku"
}

resource "github_membership" "admin" {
  count    = "${length(split(",", var.admin_users))}"
  username = "${element(split(",", var.admin_users), count.index)}"
  role     = "admin"
}

resource "github_membership" "member" {
  count    = "${length(split(",", var.member_users))}"
  username = "${element(split(",", var.member_users), count.index)}"
  role     = "member"
}

module "team_inkaku" {
  source = "./modules/team"

  name  = "inkaku"
  users = "${concat(split(",", var.admin_users), split(",", var.member_users))}"

  description = "all users"
}

resource "github_team_repository" "dot_inkaku" {
  team_id    = "${module.team_inkaku.id}"
  repository = ".inkaku"
  permission = "push"
}
