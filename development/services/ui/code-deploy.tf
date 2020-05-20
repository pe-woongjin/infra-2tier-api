data "aws_iam_role" "codedeploy-role" {
  name = var.cd_role_name
}

resource "aws_codedeploy_app" "ui-cd" {
  name              = "${local.resrc_prefix_nm}-ui-cd"
  compute_platform  = "Server"
}

resource "aws_codedeploy_deployment_group" "ui-cd-group-ming1" {
  deployment_group_name   = "group-ming1"
  deployment_config_name  = "CodeDeployDefault.AllAtOnce"
  app_name                = aws_codedeploy_app.ui-cd.name
  service_role_arn        = data.aws_iam_role.codedeploy-role.arn
  autoscaling_groups      = [ aws_autoscaling_group.ui-ming1-asg.id ]

  deployment_style {
    deployment_type = "IN_PLACE"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_codedeploy_deployment_group" "ui-cd-group-ming2" {
  deployment_group_name   = "group-ming2"
  deployment_config_name  = "CodeDeployDefault.AllAtOnce"
  app_name                = aws_codedeploy_app.ui-cd.name
  service_role_arn        = data.aws_iam_role.codedeploy-role.arn
  autoscaling_groups      = [ aws_autoscaling_group.ui-ming2-asg.id ]

  deployment_style {
    deployment_type = "IN_PLACE"
  }

  lifecycle {
    ignore_changes = all
  }
}