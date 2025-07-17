################
# IAM Settings #
################

# COMMENTED OUT: Password policy changes to prevent organization-wide password resets
# Uncomment and configure carefully if password policy changes are needed
# resource "aws_iam_account_password_policy" "password_policy" {
#   minimum_password_length        = var.password_policy_min_length
#   require_uppercase_characters   = var.password_policy_require_uppercase
#   require_lowercase_characters   = var.password_policy_require_lowercase
#   require_numbers                = var.password_policy_require_numbers
#   require_symbols                = var.password_policy_require_symbols
#   allow_users_to_change_password = var.password_policy_allow_password_changes
#   max_password_age               = var.password_policy_max_age_days
#   password_reuse_prevention      = var.password_policy_password_history_days
# }
