# HCPTerraform-Foundation
Repository to provision and manage Terraform Cloud foundation using Terraform code (IaC).

<!-- BEGIN_TF_DOCS -->
# HCP Terraform Foundation

Code which manages configuration and life-cycle of all the HCP Terraform
foundation. It is designed to be used from a dedicated VCS-Driven Terraform
Cloud workspace that would provision and manage the configuration using
Terraform code (IaC).

## Permissions

### Terraform Cloud Permissions

To manage the resources from that code, provide a token from an account with
`owner` permissions. Alternatively, you can use a token from the `owner` team
instead of a user token.

## Authentication

### Terraform Cloud Authentication

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in
order to manage resources.

* Set the `TFE_TOKEN` environment variable: The provider can read the TFE\_TOKEN
environment variable and the token stored there to authenticate. Refer to
[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables) documentation for more details.

## Features

* Manages configuration and life-cycle of Terraform Cloud resources:
  * projects
  * workspaces
  * teams
  * variable sets
  * variables
  * notifications
  * run tasks

## Prerequisite

In order to deploy the configuration from this code, you must first create
an organization. You must then configure a [VCS Provider](https://github.com/benoitblais-hashicorp/HCPTerraform-Foundation/blob/main/docs/VCS-Provider.md)
before manually creating a dedicated VCS-driven workspace in the UI.

To authenticate into Terraform Cloud during configuration deployment, an
API token must be created. This token must come from an account with `owner`
permission or the `owner` team. An environment variable `TFE_TOKEN` must be
created in the previously created workspace with the value of the generated token.

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.13.0)

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (~>0.70)

## Modules

The following Modules are called:

### <a name="module_agent_pool"></a> [agent\_pool](#module\_agent\_pool)

Source: ./modules/tfe_agent

Version:

### <a name="module_teams"></a> [teams](#module\_teams)

Source: ./modules/tfe_team

Version:

## Required Inputs

The following input variables are required:

### <a name="input_organization_email"></a> [organization\_email](#input\_organization\_email)

Description: (Required) Admin email address.

Type: `string`

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: (Required) Name of the organization.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_agent_pools"></a> [agent\_pools](#input\_agent\_pools)

Description: (Optional) A list with the name of all the agent pools available at the organization level.

Type: `list(string)`

Default: `[]`

### <a name="input_aggregated_commit_status_enabled"></a> [aggregated\_commit\_status\_enabled](#input\_aggregated\_commit\_status\_enabled)

Description: (Optional) Whether or not to enable Aggregated Status Checks. This can be useful for monorepo repositories with multiple workspaces receiving status checks for events such as a pull request. If enabled, send\_passing\_statuses\_for\_untriggered\_speculative\_plans needs to be false. Default to `true`.

Type: `bool`

Default: `true`

### <a name="input_allow_force_delete_workspaces"></a> [allow\_force\_delete\_workspaces](#input\_allow\_force\_delete\_workspaces)

Description: (Optional) Whether workspace administrators are permitted to delete workspaces with resources under management. If false, only organization owners may delete these workspaces. Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_assessments_enforced"></a> [assessments\_enforced](#input\_assessments\_enforced)

Description: (Optional) Whether to force health assessments (drift detection) on all eligible workspaces or allow workspaces to set their own preferences. Default to `true`.

Type: `bool`

Default: `true`

### <a name="input_collaborator_auth_policy"></a> [collaborator\_auth\_policy](#input\_collaborator\_auth\_policy)

Description: (Optional) Authentication policy. Valid values are `password` or `two_factor_mandatory`. Default to `two_factor_mandatory`.

Type: `string`

Default: `"two_factor_mandatory"`

### <a name="input_cost_estimation_enabled"></a> [cost\_estimation\_enabled](#input\_cost\_estimation\_enabled)

Description: (Optional) Whether or not the cost estimation feature is enabled for all workspaces in the organization. Defaults to `true`.

Type: `bool`

Default: `true`

### <a name="input_default_agent_pool_id"></a> [default\_agent\_pool\_id](#input\_default\_agent\_pool\_id)

Description: (Optional) The ID of an agent pool to assign to the workspace. Requires `default_execution_mode` to be set to `agent`. This value must not be provided if `default_execution_mode` is set to any other value.

Type: `string`

Default: `null`

### <a name="input_default_execution_mode"></a> [default\_execution\_mode](#input\_default\_execution\_mode)

Description:  (Optional) Which execution mode to use as the default for all workspaces in the organization. Valid values are `remote`, `local` or `agent`. Default to `remote`.

Type: `string`

Default: `"remote"`

### <a name="input_owners_team_saml_role_id"></a> [owners\_team\_saml\_role\_id](#input\_owners\_team\_saml\_role\_id)

Description: (Optional) The name of the "owners" team.

Type: `string`

Default: `null`

### <a name="input_send_passing_statuses_for_untriggered_speculative_plans"></a> [send\_passing\_statuses\_for\_untriggered\_speculative\_plans](#input\_send\_passing\_statuses\_for\_untriggered\_speculative\_plans)

Description: (Optional) Whether or not to send VCS status updates for untriggered speculative plans. This can be useful if large numbers of untriggered workspaces are exhausting request limits for connected version control service providers like GitHub. Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_session_remember_minutes"></a> [session\_remember\_minutes](#input\_session\_remember\_minutes)

Description: (Optional) Session expiration. Defaults to `20160`.

Type: `number`

Default: `null`

### <a name="input_session_timeout_minutes"></a> [session\_timeout\_minutes](#input\_session\_timeout\_minutes)

Description: (Optional) Session timeout after inactivity. Defaults to `20160`.

Type: `number`

Default: `null`

### <a name="input_speculative_plan_management_enabled"></a> [speculative\_plan\_management\_enabled](#input\_speculative\_plan\_management\_enabled)

Description: (Optional) Whether or not to enable Speculative Plan Management. If true, pending VCS-triggered speculative plans from outdated commits will be cancelled if a newer commit is pushed to the same branch. default to `true`.

Type: `bool`

Default: `true`

### <a name="input_teams"></a> [teams](#input\_teams)

Description:   (Optional) The teams block supports the following:  
    name                         : (Required) Name of the team.   
    organization\_access          : (Optional) The organization\_access supports the following:  
      access\_secret\_teams        : (Optional) Allow members access to secret teams up to the level of permissions granted by their team permissions setting.  
      manage\_agent\_pools         : (Optional) Allow members to create, edit, and delete agent pools within their organization.  
      manage\_membership          : (Optional) Allow members to add/remove users from the organization, and to add/remove users from visible teams.  
      manage\_modules             : (Optional) Allow members to publish and delete modules in the organization's private registry.  
      manage\_organization\_access : (Optional) Allow members to update the organization access settings of teams.  
      manage\_policies            : (Optional) Allows members to create, edit, and delete the organization's Sentinel policies.  
      manage\_policy\_overrides    : (Optional) Allows members to override soft-mandatory policy checks.  
      manage\_projects            : (Optional) Allow members to create and administrate all projects within the organization.  
      manage\_providers           : (Optional) Allow members to publish and delete providers in the organization's private registry.  
      manage\_run\_tasks           : (Optional) Allow members to create, edit, and delete the organization's run tasks.  
      manage\_teams               : (Optional) Allow members to create, update, and delete teams.  
      manage\_vcs\_settings        : (Optional) Allows members to manage the organization's VCS Providers and SSH keys.  
      manage\_workspaces          : (Optional) Allows members to create and administrate all workspaces within the organization.  
      read\_projects              : (Optional) Allow members to view all projects within the organization. Requires read\_workspaces to be set to true.  
      read\_workspaces            : (Optional) Allow members to view all workspaces in this organization.  
    sso\_team\_id                  : (Optional) Unique Identifier to control team membership via SAML.  
    token                        : (Optional) If set to `true`, a team token will be generated.  
    token\_description            : (Optional) The token's description, which must be unique per team. Required if creating multiple tokens for a single team.  
    token\_expired\_at             : (Optional) The token's expiration date. The expiration date must be a date/time string in RFC3339 format (e.g., '2024-12-31T23:59:59Z'). If no expiration date is supplied, the expiration date will default to null and never expire.  
    token\_force\_regenerate       : (Optional) If set to `true`, a new token will be generated even if a token already exists. This will invalidate the existing token!  
    visibility                   : (Optional) The visibility of the team (`secret` or `organization`).

Type:

```hcl
list(object({
    name = string
    organization_access = optional(object({
      access_secret_teams        = optional(bool, false)
      manage_agent_pools         = optional(bool, false)
      manage_membership          = optional(bool, false)
      manage_modules             = optional(bool, false)
      manage_organization_access = optional(bool, false)
      manage_policies            = optional(bool, false)
      manage_policy_overrides    = optional(bool, false)
      manage_projects            = optional(bool, false)
      manage_providers           = optional(bool, false)
      manage_run_tasks           = optional(bool, false)
      manage_teams               = optional(bool, false)
      manage_vcs_settings        = optional(bool, false)
      manage_workspaces          = optional(bool, false)
      read_projects              = optional(bool, false)
      read_workspaces            = optional(bool, false)
    }), null)
    sso_team_id            = optional(string)
    token                  = optional(bool, false)
    token_description      = optional(string)
    token_expired_at       = optional(string)
    token_force_regenerate = optional(bool, false)
    visibility             = optional(string, "organization")
  }))
```

Default: `[]`

## Resources

The following resources are used by this module:

- [tfe_organization.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization) (resource)
- [tfe_organization_default_settings.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_default_settings) (resource)

## Outputs

No outputs.

<!-- markdownlint-enable -->
<!-- END_TF_DOCS -->