##############
# IAM Groups #
##############

# Full-Admin (can do everything, MFA Restricted)
# Full-Admin (Role)
# Operations-Admin (can create,delete,update IAM users, Region Restricted, MFA Restricted)
# Resource-Admin (can create,delete,update resources but not IAM users, Region Restricted, MFA Restricted)
# Deployer-Admin (can create,delete,update resources but not IAM users, Region Restricted)
# Read-Only (can read stuff, Region Restricted,  MFA Restricted)

data "aws_iam_policy_document" "require_mfa" {
  statement {
    sid    = "AllowAllUsersToListAccounts"
    effect = "Allow"
    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
  statement {
    sid     = "AllowIndividualUserToListOnlyTheirOwnMFA"
    effect  = "Allow"
    actions = ["iam:ListMFADevices"]
    resources = [
      "arn:aws:iam::*:mfa/*",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
  }
  statement {
    sid    = "AllowIndividualUserToManageTheirOwnMFA"
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
  }
  statement {
    sid     = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    effect  = "Allow"
    actions = ["iam:DeactivateMFADevice"]
    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}"
    ]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
  statement {
    sid    = "BlockMostAccessUnlessSignedInWithMFA"
    effect = "Deny"
    not_actions = [
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:CreateVirtualMFADevice",
      "iam:ListVirtualMFADevices",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListSSHPublicKeys",
      "iam:ListAccessKeys",
      "iam:ListServiceSpecificCredentials",
      "iam:ListMFADevices",
      "iam:GetAccountSummary",
      "sts:GetSessionToken"
    ]
    resources = ["*"]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}


data "aws_iam_policy_document" "saml_assume" {
  count = length(var.saml_provider_arn) > 0 ? 1 : 0
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [var.saml_provider_arn]
    }
    actions = ["sts:AssumeRoleWithSAML"]
    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://signin.aws.amazon.com/saml"]
    }
  }
}

resource "aws_iam_role" "full_admin" {
  count              = length(var.saml_provider_arn) > 0 ? 1 : 0
  name               = "full-admin"
  assume_role_policy = data.aws_iam_policy_document.saml_assume[count.index].json
}

resource "aws_iam_role_policy_attachment" "full_admin" {
  count = length(var.saml_provider_arn) > 0 ? 1 : 0

}

resource "aws_iam_role_policy" "full_admin" {
  count  = length(var.saml_provider_arn) > 0 ? 1 : 0
  name   = "full-admin"
  role   = aws_iam_role.full_admin[count.index].id
  policy = data.aws_iam_policy_document.require_mfa.json
}
