provider "github" {
  organization = "inkaku"
}

resource "github_membership" "hiroqn" {
  username = "hiroqn"
  role     = "admin"
}

resource "github_membership" "taketo957" {
  username = "taketo957"
  role     = "admin"
}

resource "github_membership" "omatty198" {
  username = "omatty198"
}

resource "github_membership" "ryota-ka" {
  username = "ryota-ka"
}

resource "github_membership" "ytsk" {
  username = "ytsk"
}

resource "github_membership" "takanarisun" {
  username = "takanarisun"
}

resource "github_team" "inkaku" {
  name        = "inkaku"
  description = "all members"
  privacy     = "closed"
}

resource "github_team_membership" "inkaku_hiroqn" {
  team_id  = "${github_team.inkaku.id}"
  username = "${github_membership.hiroqn.username}"
}

resource "github_team_membership" "inkaku_taketo957" {
  team_id  = "${github_team.inkaku.id}"
  username = "${github_membership.taketo957.username}"
}

resource "github_team_membership" "inkaku_omatty198" {
  team_id  = "${github_team.inkaku.id}"
  username = "${github_membership.omatty198.username}"
}

resource "github_team_membership" "inkaku_ryota-ka" {
  team_id  = "${github_team.inkaku.id}"
  username = "${github_membership.ryota-ka.username}"
}

resource "github_team_membership" "inkaku_ytsk" {
  team_id  = "${github_team.inkaku.id}"
  username = "${github_membership.ytsk.username}"
}

resource "github_team_membership" "inkaku_takanarisun" {
  team_id  = "${github_team.inkaku.id}"
  username = "${github_membership.takanarisun.username}"
}

resource "github_team_repository" "dot_inkaku" {
  team_id    = "${github_team.inkaku.id}"
  repository = ".inkaku"
  permission = "push"
}
