resource "aws_ecr_repository" "nginx" {
  name = "nginx-site"
}

resource "aws_ecs_cluster" "nginx" {
  name = "nginx_cluster"
}

resource "aws_ecs_task_definition" "nginx" {
  family = "nginx-task"
  container_definitions = "${data.template_file.nginx-container.rendered}"
}

resource "aws_ecs_service" "nginx" {
  name = "nginx-service"
  cluster = "${aws_ecs_cluster.nginx.id}"
  task_definition = "${aws_ecs_task_definition.nginx.arn}"
  desired_count = 1
}