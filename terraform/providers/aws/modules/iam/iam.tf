variable "name" {}

variable "users" {}

variable "policy" {}

resource "aws_iam_group" "group" {
  name = "${var.name}-group"
}

resource "aws_iam_group_policy" "policy" {
  name   = "${var.name}"
  group  = "${aws_iam_group.group.id}"
  policy = "${var.policy}"
}

resource "aws_iam_user" "user" {
  count = "${length(split(",", var.users))}"
  name  = "${element(split(",", var.users), count.index)}"
}

resource "aws_iam_group_membership" "membership" {
  name  = "${var.name}"
  group = "${aws_iam_group.group.name}"
  users = ["${aws_iam_user.user.*.name}"]
}
