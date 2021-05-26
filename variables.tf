variable "saml_provider_arn" {
  type        = string
  description = "(optional) The AWS Resource Name (ARN) for the Security Assertion Markup Language (SAML) provider"
  default     = ""
}

variable "allowed_regions" {
  type        = list(any)
  description = "(optional) A list of the allowed regions (defaults to [\"us-east-1\", \"us-west-1\"])"
  default     = ["us-east-1", "us-west-1"]
}

variable "password_policy_min_length" {
  type        = number
  description = "(optional) the number representing the minimum password length"
  default     = 16
}

variable "password_policy_require_uppercase" {
  type        = bool
  description = "(optional) the boolean value indicating whether to require uppercase characters in passwords"
  default     = true
}

variable "password_policy_require_lowercase" {
  type        = bool
  description = "(optional) the boolean value indicating whether to require lowercase characters in passwords"
  default     = true
}

variable "password_policy_require_numbers" {
  type        = bool
  description = "(optional) the boolean value indicating whether to require numbers in passwords"
  default     = true
}

variable "password_policy_require_symbols" {
  type        = bool
  description = "(optional) the boolean value indicating whether to require symbols in passwords"
  default     = true
}

variable "password_policy_allow_password_changes" {
  type        = bool
  description = "(optional) the boolean value indicating whether to allow users to change their passwords"
  default     = true
}

variable "password_policy_max_age_days" {
  type        = number
  description = "(optional) the number representing the number of days before a password should expire"
  default     = 90
}

variable "password_policy_password_history_days" {
  type        = number
  description = "(optional) the number representing the number of previous passwords to remember"
  default     = 24
}
