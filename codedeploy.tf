resource "aws_iam_role" "examplean" {
  name = "example-rolean"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.examplean.name
}

resource "aws_codedeploy_app" "anand_app12" {
  compute_platform = "Server"
  name             = "anand_app12"
}




resource "aws_codedeploy_deployment_group" "example1" {
  app_name              = aws_codedeploy_app.anand_app12.name
  deployment_group_name = "example-group1"
  service_role_arn      = aws_iam_role.examplean.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "codecimmit-terraform_instace"
    }

  }



  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}