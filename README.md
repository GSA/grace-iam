# <a name="top">GRACE IAM</a>

GRACE IAM provides a basic configuration for AWS Identity and Access Management (IAM) that provides generic roles and groups for general-purpose AWS environments.

## Table of Contents

- [Security Compliance](#security-compliance)
- [Groups, Roles, and Policies](#groups-roles-and-policies)
- [Repository contents](#repository-contents)
- [Usage](#usage)
- [Terraform Module Inputs](#terraform-module-inputs)
- [Terraform Module Outputs](#terraform-module-outputs)

## Security Compliance
The GRACE IAM subcomponent provides various levels of coverage for several [NIST Special Publication 800-53 (Rev. 4) Security Controls](https://nvd.nist.gov/800-53/Rev4/impact/moderate).  These security controls are designated for [FIPS 199 Moderate Impact Systems](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.199.pdf). Additional information regarding the implementation method utilized can be found within the [GRACE Component Control Coverage Repository](https://github.com/GSA/grace-ssp/blob/master/README.md).

**Component ATO status:** draft

**Relevant controls:**

Control    | CSP/AWS | HOST/OS | App/DB | How is it implemented?
---------- | ------- | ------- | ------ | ----------------------
[AC-3](https://nvd.nist.gov/800-53/Rev4/control/AC-3) | ╳ | | | The use of IAM groups, roles, and policies are utilized to enforce logical access to the system and provide permissions to perform specific actions on specific AWS resources and services.
[AC-5(a)](https://nvd.nist.gov/800-53/Rev4/control/AC-5) | ╳ | | | The use of IAM groups, roles, and policies are utilized to enforce the separation of duties of individuals.
[IA-2(1)](https://nvd.nist.gov/800-53/Rev4/control/IA-2#enhancement-1) | ╳ | | | The [require_mfa](https://github.com/GSA/grace-iam/blob/master/policies.tf) IAM policy is used to enforce multifactor authentication for privileged users of the information system.
[IA-2(3)](https://nvd.nist.gov/800-53/Rev4/control/IA-2#enhancement-3) | ╳ | | | The [require_mfa](https://github.com/GSA/grace-iam/blob/master/policies.tf) IAM policy is used to enforce multifactor authentication for privileged users of the information system.
[IA-2(11)](https://nvd.nist.gov/800-53/Rev4/control/IA-2#enhancement-11) | ╳ | | | The [require_mfa](https://github.com/GSA/grace-iam/blob/master/policies.tf) IAM policy is used in conjunction with virtual MFA devices or authenticator applications such as  Google Authenticator. These virtual MFA applications are installed on smartphone devices and are used to provide the secondary factor information for completing authentication.
[IA-5(1)](https://nvd.nist.gov/800-53/Rev4/control/IA-5#enhancement-1) | ╳ | | | The IAM [password_policy](https://github.com/GSA/grace-iam/blob/master/iam.tf) enforces a minimum password length, complexity, maximum lifetime, reuse parameter, and requires the user to change their initial account setup password upon first login.  


[top](#top)

## Groups, Roles, and Policies

### Policies

|Name|Purpose|
|----|-------|
| full-admin | Allows full administrator access |
| require-mfa | Forces multi-factor authentication usage before privileges are granted |
| partial-admin | Allows region-restricted administrator access (excluding IAM, Organizations, and sts:AssumeRole) |
| iam-admin | Allows administrator access to IAM |
| ReadOnlyAccess | Allows read only access to the AWS environment |

### Groups

|Name|Policies|
|----|-------|
| full-admin | `full-admin` `require-mfa` |
| ops-admin | `partial-admin` `iam-admin` `require-mfa` |
| resource-admin | `partial-admin` `require-mfa` |
| deployer-admin | `full-admin` |
| read-only | `ReadOnlyAccess` |


### Roles

Roles are only created if the saml_provider_arn is provided. This is useful if your account uses federation.

|Name|Policies|
|----|-------|
| full-admin | `full-admin` `require-mfa` |
| ops-admin | `partial-admin` `iam-admin` `require-mfa` |
| resource-admin | `partial-admin` `require-mfa` |
| deployer-admin | `full-admin` |
| read-only | `ReadOnlyAccess` |

[top](#top)

## Repository contents

- **groups.tf** contains the AWS IAM group declarations and policy attachments
- **iam.tf** contains the AWS IAM password management policy declaration
- **policies.tf** contains the AWS IAM policy declarations and policy documents
- **roles.tf** contains the AWS IAM role declarations and policy attachments (dependent on the `saml_provider_arn` value)
- **variables.tf** contains all configurable variables
- **outputs.tf** contains all Terraform output variables

[top](#top)

# Usage

Simply import grace-iam as a module into your Terraform for the destination AWS Environment.

```
module "iam" {
    source = "github.com/GSA/grace-iam?ref=v0.0.1"
}
```

[top](#top)

## Terraform Module Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| saml_provider_arn | The AWS Resource Name (ARN) for the Security Assertion Markup Language (SAML) provider | string | "" | no |
| allowed_regions | A list of the allowed regions | list | us-east-1, us-west-1 | no |
| password_policy_min_length | the number representing the minimum password length | number | 16 | no |
| password_policy_require_uppercase | the boolean value indicating whether to require uppercase characters in passwords | bool | true | no |
| password_policy_require_lowercase | the boolean value indicating whether to require lowercase characters in passwords | bool | true | no |
| password_policy_require_numbers | the boolean value indicating whether to require numbers in passwords | bool | true | no |
| password_policy_require_symbols | the boolean value indicating whether to require symbols in passwords | bool | true | no |
| password_policy_allow_password_changes | the boolean value indicating whether to allow users to change their passwords | bool | true | no |
| password_policy_max_age_days | the number representing the number of days before a password should expire | number | 90 | no |
| password_policy_password_history_days | the number representing the number of previous passwords to remember | number | 24 | no |

[top](#top)


## Terraform Module Outputs

| Name | Description |
|------|-------------|
| full_admin_group_arn | The ARN of the full-admin IAM group |
| ops_admin_group_arn | The ARN of the ops-admin IAM group |
| resource_admin_group_arn | The ARN of the resource-admin IAM group |
| deployer_admin_group_arn | The ARN of the deployer-admin IAM group |
| read_only_group_arn | The ARN of the read-only IAM group |
| full_admin_policy_arn | The ARN of the full-admin IAM policy |
| iam_admin_policy_arn | The ARN of the iam-admin IAM policy |
| partial_admin_policy_arn | The ARN of the partial-admin IAM policy |
| require_mfa_policy_arn | The ARN of the require-mfa IAM policy |
| full_admin_role_arn | The ARN of the full-admin IAM role (requires saml_provider_arn) |
| ops_admin_role_arn | The ARN of the ops-admin IAM role (requires saml_provider_arn) |
| resource_admin_role_arn | The ARN of the resource-admin IAM role (requires saml_provider_arn) |
| deployer_admin_role_arn | The ARN of the deployer-admin IAM role (requires saml_provider_arn) |
| read_only_role_arn | The ARN of the read-only IAM role (requires saml_provider_arn) |

[top](#top)


## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.

[top](#top)
