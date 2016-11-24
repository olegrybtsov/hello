resource "aws_placement_group" "nginx" {
  name = "nginx_group"
  strategy = "cluster"
}

resource "aws_iam_role" "instance_role" {
  
  name = "instance_role"

  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {"AWS": "*"},
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "instance_policy" {
  name = "instance_policy"

  role = "${aws_iam_role.instance_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF

}

#resource "aws_iam_policy_attachment" "instance_attachment" {
#  name = "nginxEscIntanceRole"
#
#  roles = ["${aws_iam_role.instance_role.arn}"]
#
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
#
#}

resource "aws_iam_instance_profile" "instance_profile" {
  roles = ["${aws_iam_role.instance_role.name}"]
}

resource "aws_launch_configuration" "nginx" {
  name_prefix = "nginx-cluster-"
  image_id =  "${lookup(var.aws_ami, var.aws_region)}"
  instance_type = "t2.micro"
 
  user_data = "${data.template_file.userdata.rendered}"

  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"
 
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nginx" {
  availability_zones = ["us-east-1a"]
  min_size = 1
  max_size = 3
 
  launch_configuration = "${aws_launch_configuration.nginx.name}"
 
  lifecycle {
    create_before_destroy = true
  }
}