variable "key_name" {
  description = "Public key name"
  default = "public"
}

variable "public_key_path" {
  description = "Path to public key file"
  default = "key.pub"
}

variable "aws_region" {
  description = "AWS region to launch servers"
  default = "us-east-1"
}

variable "aws_ami" {
  default = {
    us-east-1 = "ami-eca289fb"
    us-east-2 = "ami-446f3521"
    us-west-1 = "ami-9fadf8ff"
    us-west-2 = "ami-7abc111a"
    eu-west-1 = "ami-a1491ad2"
    eu-central-1 = "ami-54f5303b"
    ap-northeast-1 = "ami-9cd57ffd"
    ap-southeast-1 = "ami-a900a3ca"
    ap-southeast-2 = "ami-5781be34"
  }
}