output "full_admin_group_arn" {
  value = aws_iam_group.full_admin.arn
}
output "ops_admin_group_arn" {
  value = aws_iam_group.ops_admin.arn
}
output "resource_admin_group_arn" {
  value = aws_iam_group.resource_admin.arn
}
output "deployer_admin_group_arn" {
  value = aws_iam_group.deployer_admin.arn
}
output "ready_only_group_arn" {
  value = aws_iam_group.read_only.arn
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
