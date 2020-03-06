##############
# IAM Groups #
##############

# full-admin group
resource "aws_iam_group" "full_admin" {
  name = "full-admin"
}

# attach full-admin policy to full-admin group
resource "aws_iam_group_policy_attachment" "full_admin" {
  group      = aws_iam_group.full_admin.name
  policy_arn = aws_iam_policy.full_admin.arn
}

# attach require-mfa policy to full-admin group
resource "aws_iam_group_policy_attachment" "full_admin_mfa" {
  group      = aws_iam_group.full_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# ops-admin group
resource "aws_iam_group" "ops_admin" {
  name = "ops-admin"
}

# attach partial-admin policy to ops-admin group
resource "aws_iam_group_policy_attachment" "ops_admin" {
  group      = aws_iam_group.ops_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}

# attach iam-admin policy to ops-admin group
resource "aws_iam_group_policy_attachment" "ops_admin_iam" {
  group      = aws_iam_group.ops_admin.name
  policy_arn = aws_iam_policy.iam_admin.arn
}

# attach require-mfa policy to ops-admin group
resource "aws_iam_group_policy_attachment" "ops_admin_mfa" {
  group      = aws_iam_group.ops_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# resource-admin group
resource "aws_iam_group" "resource_admin" {
  name = "resource-admin"
}

# attach partial-admin policy to resource-admin group
resource "aws_iam_group_policy_attachment" "resource_admin" {
  group      = aws_iam_group.resource_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}

# attach require-mfa policy to resource-admin group
resource "aws_iam_group_policy_attachment" "resource_admin_mfa" {
  group      = aws_iam_group.resource_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# deployer-admin group
resource "aws_iam_group" "deployer_admin" {
  name = "deployer-admin"
}

# attach partial-admin policy to deployer-admin group
resource "aws_iam_group_policy_attachment" "deployer_admin" {
  group      = aws_iam_group.deployer_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}
