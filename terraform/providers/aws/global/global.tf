variable "name" {}

variable "region" {}

variable "iam_admins" {}

variable "domain_inkaku_ink" {
  default = "inkaku.ink"
}

provider "aws" {
  region = "${var.region}"
}

module "iam_admin" {
  source = "../modules/iam"

  name  = "${var.name}-admin"
  users = "${var.iam_admins}"

  policy = <<EOF
{
  "Version"  : "2012-10-17",
  "Statement": [
    {
      "Effect"  : "Allow",
      "Action"  : "*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_route53_zone" "inkaku_ink" {
  name = "${var.domain_inkaku_ink}"
}

resource "aws_route53_record" "inkaku_ink_root" {
  zone_id = "${aws_route53_zone.inkaku_ink.zone_id}"
  name    = "${var.domain_inkaku_ink}"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.inkaku_ink.website_domain}"
    zone_id                = "${aws_s3_bucket.inkaku_ink.hosted_zone_id}"
    evaluate_target_health = false
  }
}

output "ns" {
  value = "${join(",", aws_route53_zone.inkaku_ink.name_servers)}"
}

resource "aws_s3_bucket" "inkaku_ink" {
  bucket        = "${var.domain_inkaku_ink}"
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.domain_inkaku_ink}/*"
    }
  ]
}
EOF
}

output "domain" {
  value = "${aws_s3_bucket.inkaku_ink.website_domain}"
}

output "hosted_zone_id" {
  value = "${aws_s3_bucket.inkaku_ink.hosted_zone_id}"
}

output "endpoint" {
  value = "${aws_s3_bucket.inkaku_ink.website_endpoint}"
}
