output "full_admin_group_arn" {
  value = var.create_iam_groups ? aws_iam_group.full_admin[0].arn : ""
}
output "ops_admin_group_arn" {
  value = var.create_iam_groups ? aws_iam_group.ops_admin[0].arn : ""
}
output "resource_admin_group_arn" {
  value = var.create_iam_groups ? aws_iam_group.resource_admin[0].arn : ""
}
output "deployer_admin_group_arn" {
  value = var.create_iam_groups ? aws_iam_group.deployer_admin[0].arn : ""
}
output "ready_only_group_arn" {
  value = var.create_iam_groups ? aws_iam_group.read_only[0].arn : ""
}

output "full_admin_policy_arn" {
  value = aws_iam_policy.full_admin.arn
}
output "iam_admin_policy_arn" {
  value = aws_iam_policy.iam_admin.arn
}
output "partial_admin_policy_arn" {
  value = aws_iam_policy.partial_admin.arn
}
output "require_mfa_policy_arn" {
  value = aws_iam_policy.require_mfa.arn
}

output "full_admin_role_arn" {
  value = length(var.saml_provider_arn) > 0 ? aws_iam_role.full_admin[0].arn : ""
}
output "ops_admin_role_arn" {
  value = length(var.saml_provider_arn) > 0 ? aws_iam_role.ops_admin[0].arn : ""
}
output "resource_admin_role_arn" {
  value = length(var.saml_provider_arn) > 0 ? aws_iam_role.resource_admin[0].arn : ""
}
output "deployer_admin_role_arn" {
  value = length(var.saml_provider_arn) > 0 ? aws_iam_role.deployer_admin[0].arn : ""
}
output "read_only_role_arn" {
  value = length(var.saml_provider_arn) > 0 ? aws_iam_role.read_only[0].arn : ""
}
