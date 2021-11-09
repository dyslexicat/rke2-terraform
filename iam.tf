resource "aws_iam_instance_profile" "rancher_profile" {
  name = "rancher_profile"
  role = "rke2-aws-role"
}
