data "template_file" "nginx-container" {
  template = "${file("templates/nginx-containers.tpl")}"

  vars {
    repository_address = "${replace(aws_ecr_repository.nginx.repository_url, "/^.*:///", "")}"
  }
}

data "template_file" "userdata" {
  template = "${file("templates/userdata.tpl")}"

  vars {
    cluster_name = "${aws_ecs_cluster.nginx.name}"
  }
}