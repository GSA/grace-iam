##############
# IAM Groups #
##############

# full-admin group
resource "aws_iam_group" "full_admin" {
  count = var.create_iam_groups ? 1 : 0

  name = "full-admin"
}

# attach full-admin policy to full-admin group
resource "aws_iam_group_policy_attachment" "full_admin" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.full_admin[0].name
  policy_arn = aws_iam_policy.full_admin.arn
}

# attach require-mfa policy to full-admin group
resource "aws_iam_group_policy_attachment" "full_admin_mfa" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.full_admin[0].name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# ops-admin group
resource "aws_iam_group" "ops_admin" {
  count = var.create_iam_groups ? 1 : 0

  name = "ops-admin"
}

# attach partial-admin policy to ops-admin group
resource "aws_iam_group_policy_attachment" "ops_admin" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.ops_admin[0].name
  policy_arn = aws_iam_policy.partial_admin.arn
}

# attach iam-admin policy to ops-admin group
resource "aws_iam_group_policy_attachment" "ops_admin_iam" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.ops_admin[0].name
  policy_arn = aws_iam_policy.iam_admin.arn
}

# attach require-mfa policy to ops-admin group
resource "aws_iam_group_policy_attachment" "ops_admin_mfa" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.ops_admin[0].name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# resource-admin group
resource "aws_iam_group" "resource_admin" {
  count = var.create_iam_groups ? 1 : 0

  name = "resource-admin"
}

# attach partial-admin policy to resource-admin group
resource "aws_iam_group_policy_attachment" "resource_admin" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.resource_admin[0].name
  policy_arn = aws_iam_policy.partial_admin.arn
}

# attach require-mfa policy to resource-admin group
resource "aws_iam_group_policy_attachment" "resource_admin_mfa" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.resource_admin[0].name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# deployer-admin group
resource "aws_iam_group" "deployer_admin" {
  count = var.create_iam_groups ? 1 : 0

  name = "deployer-admin"
}

# attach full-admin policy to deployer-admin group
resource "aws_iam_group_policy_attachment" "deployer_admin" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.deployer_admin[0].name
  policy_arn = aws_iam_policy.full_admin.arn
}

# read-only group
resource "aws_iam_group" "read_only" {
  count = var.create_iam_groups ? 1 : 0

  name = "read-only"
}

# attach ReadOnlyAccess policy to read-only group
resource "aws_iam_group_policy_attachment" "read_only" {
  count = var.create_iam_groups ? 1 : 0

  group      = aws_iam_group.read_only[0].name
  policy_arn = data.aws_iam_policy.read_only.arn
}
