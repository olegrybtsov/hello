provider "aws" {
	access_key = "AKIAJHRHCV4VOR3TRWEA"
	secret_key = "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"
	region = "eu-central-1"
}

resource "aws_instance" "ryb_tf" {
	ami = "ami-e4c63e8b"
	instance_type = "t2.micro"
	tags {
		Name = "rybtsov_tf"
	}
	key_name = "rybkeys"
	security_groups = ["rybsg"]
}