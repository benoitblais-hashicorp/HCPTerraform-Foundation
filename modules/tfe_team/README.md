# TFC teams Terraform module

Terraform teams module which manages configuration and life-cycle of all
your Terraform Cloud teams.

## Permissions

To manage the team resources, provide a user token from an account with 
appropriate permissions. This user should belong to the `owners` team. 
Alternatively, you can use a token from the owners team instead of a user token.

## Authentication

The Terraform Cloud provider requires a Terraform Cloud/Enterprise API token in 
order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the token argument in the provider configuration. Use an
input variable for the token.
- Set the `TFE_TOKEN` environment variable. The provider can read the TFE_TOKEN environment variable and the token stored there
to authenticate.

## Features

- Create and manage Terraform Cloud teams.
- Manage team's organization access.
- Manage team's members.
- Generates a new team token and overrides existing token if one exists.
- Manage team's permissions on a project.
- Manage team's permissions on a workspace.

## Usage example
```hcl
module "team" {
  source = "./modules/tfe_team"

  name           = "Team Name"
  sso_team_id    = "Microsoft Entra Group Id"
  organization   = "Organization Name"
  token          = true
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (~>0.70)

## Providers

The following providers are used by this module:

- <a name="provider_tfe"></a> [tfe](#provider\_tfe) (~>0.70)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [tfe_team.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) (resource)
- [tfe_team_organization_members.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_organization_members) (resource)
- [tfe_team_token.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_token) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: (Required) Name of the team.

Type: `string`

### <a name="input_organization"></a> [organization](#input\_organization)

Description: (Required) Name of the organization. If omitted, organization must be defined in the provider config.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_organization_access"></a> [organization\_access](#input\_organization\_access)

Description:   (Optional) Settings for the team's organization access.  
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

Type:

```hcl
object({
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
  })
```

Default: `null`

### <a name="input_organization_membership_ids"></a> [organization\_membership\_ids](#input\_organization\_membership\_ids)

Description: (Required) IDs of organization memberships to be added.

Type: `list(string)`

Default: `[]`

### <a name="input_sso_team_id"></a> [sso\_team\_id](#input\_sso\_team\_id)

Description: (Optional) Unique Identifier to control team membership via SAML.

Type: `string`

Default: `null`

### <a name="input_token"></a> [token](#input\_token)

Description: (Optional) If set to `true`, a team token will be generated.

Type: `bool`

Default: `false`

### <a name="input_token_description"></a> [token\_description](#input\_token\_description)

Description: (Optional) The token's description, which must be unique per team. Required if creating multiple tokens for a single team.

Type: `string`

Default: `null`

### <a name="input_token_expired_at"></a> [token\_expired\_at](#input\_token\_expired\_at)

Description: (Optional) The token's expiration date. The expiration date must be a date/time string in RFC3339 format (e.g., '2024-12-31T23:59:59Z'). If no expiration date is supplied, the expiration date will default to null and never expire.

Type: `string`

Default: `null`

### <a name="input_token_force_regenerate"></a> [token\_force\_regenerate](#input\_token\_force\_regenerate)

Description: (Optional) If set to `true`, a new token will be generated even if a token already exists. This will invalidate the existing token!

Type: `bool`

Default: `false`

### <a name="input_visibility"></a> [visibility](#input\_visibility)

Description: (Optional) The visibility of the team (`secret` or `organization`).

Type: `string`

Default: `"organization"`

## Outputs

The following outputs are exported:

### <a name="output_team"></a> [team](#output\_team)

Description: Terraform Cloud team resource.

### <a name="output_team_id"></a> [team\_id](#output\_team\_id)

Description: The ID of the team.

### <a name="output_token"></a> [token](#output\_token)

Description: The generated token.

### <a name="output_token_id"></a> [token\_id](#output\_token\_id)

Description: The ID of the token.
<!-- END_TF_DOCS -->