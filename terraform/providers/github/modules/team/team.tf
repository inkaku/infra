variable "name" {}

variable "description" {}

variable "privacy" {
  default = "closed"
}

variable "users" {}

resource "github_team" "team" {
  name        = "${var.name}"
  description = "${var.description}"
  privacy     = "${var.privacy}"
}

resource "github_team_membership" "membership" {
  count    = "${length(var.users)}"
  team_id  = "${github_team.team.id}"
  username = "${element(var.users, count.index)}"
}

output "id" {
  value = "${github_team.team.id}"
}
