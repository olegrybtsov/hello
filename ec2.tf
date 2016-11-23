provider "aws" {
        access_key = "AKIAJZTCZO5P3PU7OY2A"
        secret_key = "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"
        region = "eu-central-1"
}

resource "aws_instance" "RH" {
        ami = "ami-e4c63e8b"
        instance_type = "t2.micro"
        tags {
                Name = "RH"
        }
        key_name = "mykey"
        security_groups = ["launch-wizard-1"]
}

output "lb_address" {
  value = "${RH.web.public_dns}"
}