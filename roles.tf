###############
#  IAM Roles  #
###############

# full-admin role
resource "aws_iam_role" "full_admin" {
  count              = length(var.saml_provider_arn) > 0 ? 1 : 0
  name               = "full-admin"
  assume_role_policy = data.aws_iam_policy_document.saml_assume[count.index].json
}

# attach full-admin policy to full-admin role
resource "aws_iam_role_policy_attachment" "full_admin" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.full_admin.name
  policy_arn = aws_iam_policy.full_admin.arn
}

# ops-admin role
resource "aws_iam_role" "ops_admin" {
  count              = length(var.saml_provider_arn) > 0 ? 1 : 0
  name               = "ops-admin"
  assume_role_policy = data.aws_iam_policy_document.saml_assume[count.index].json
}

# attach partial-admin policy to ops-admin role
resource "aws_iam_role_policy_attachment" "ops_admin" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.ops_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}

# attach iam-admin policy to ops-admin role
resource "aws_iam_role_policy_attachment" "ops_admin_iam" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.ops_admin.name
  policy_arn = aws_iam_policy.iam_admin.arn
}

# attach require-mfa policy to ops-admin role
resource "aws_iam_role_policy_attachment" "ops_admin_mfa" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.ops_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# resource-admin role
resource "aws_iam_role" "resource_admin" {
  count              = length(var.saml_provider_arn) > 0 ? 1 : 0
  name               = "resource-admin"
  assume_role_policy = data.aws_iam_policy_document.saml_assume[count.index].json
}

# attach partial-admin policy to resource-admin role
resource "aws_iam_role_policy_attachment" "resource_admin" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.resource_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}

# attach require-mfa policy to resource-admin role
resource "aws_iam_role_policy_attachment" "resource_admin_mfa" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.resource_admin.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

# deployer-admin role
resource "aws_iam_role" "deployer_admin" {
  count              = length(var.saml_provider_arn) > 0 ? 1 : 0
  name               = "deployer-admin"
  assume_role_policy = data.aws_iam_policy_document.saml_assume[count.index].json
}

# attach partial-admin policy to deployer-admin role
resource "aws_iam_role_policy_attachment" "deployer_admin" {
  count      = length(var.saml_provider_arn) > 0 ? 1 : 0
  role       = aws_iam_role.deployer_admin.name
  policy_arn = aws_iam_policy.partial_admin.arn
}
