variable "saml_provider_arn" {
  type        = string
  description = "(optional) The AWS Resource Name (ARN) for the Security Assertion Markup Language (SAML) provider"
}
variable "allowed_regions" {
  type        = list
  description = "(optional) A list of the allowed regions (defaults to [\"us-east-1\", \"us-west-1\"])"
  default = ["us-east-1", "us-west-1"]
}
