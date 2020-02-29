##############
# IAM Groups #
##############

# Full-Admin (can do everything, MFA Restricted)
# Full-Admin (Role)
# Operations-Admin (can create,delete,update IAM users, Region Restricted, MFA Restricted)
# Resource-Admin (can create,delete,update resources but not IAM users, Region Restricted, MFA Restricted)
# Deployer-Admin (can create,delete,update resources but not IAM users, Region Restricted)
# Read-Only (can read stuff, Region Restricted,  MFA Restricted)

resource "aws_iam_group" "full_admin" {
  name = "full-admin"
}

resource "aws_iam_group_policy_attachment" "full_admin" {
  group      = aws_iam_group.full_admin.name
  policy_arn = aws_iam_policy.full_admin.arn
}

resource "aws_iam_group_policy_attachment" "full_admin_mfa" {
  group      = aws_iam_group.full_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

resource "aws_iam_group" "ops_admin" {
  name = "ops-admin"
}

resource "aws_iam_group_policy_attachment" "ops_admin" {
  group      = aws_iam_group.ops_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}

resource "aws_iam_group_policy_attachment" "ops_admin_iam" {
  group      = aws_iam_group.ops_admin.name
  policy_arn = aws_iam_policy.iam_admin.arn
}

resource "aws_iam_group_policy_attachment" "ops_admin_mfa" {
  group      = aws_iam_group.ops_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

resource "aws_iam_group" "resource_admin" {
  name = "resource-admin"
}

resource "aws_iam_group_policy_attachment" "resource_admin" {
  group      = aws_iam_group.resource_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}

resource "aws_iam_group_policy_attachment" "resource_admin_mfa" {
  group      = aws_iam_group.resource_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}
