output "repository_url" {
  value = "${aws_ecr_repository.nginx.repository_url}"
}

output "loadbalancer_url" {
  value = "${aws_elb.web.dns_name}"
}