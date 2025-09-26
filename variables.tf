variable "organization_email" {
  description = "(Required) Admin email address."
  type        = string
  nullable    = false
}

variable "organization_name" {
  description = "(Required) Name of the organization."
  type        = string
  nullable    = false
}

variable "agent_pools" {
  description = "(Optional) A list with the name of all the agent pools available at the organization level."
  type        = list(string)
  default     = []
}

variable "aggregated_commit_status_enabled" {
  description = "(Optional) Whether or not to enable Aggregated Status Checks. This can be useful for monorepo repositories with multiple workspaces receiving status checks for events such as a pull request. If enabled, send_passing_statuses_for_untriggered_speculative_plans needs to be false. Default to `true`."
  type        = bool
  default     = true

  validation {
    condition     = var.aggregated_commit_status_enabled ? var.send_passing_statuses_for_untriggered_speculative_plans == false ? true : false : true
    error_message = "If `aggregated_commit_status_enabled` is enabled, `send_passing_statuses_for_untriggered_speculative_plans` needs to be false."
  }
}

variable "allow_force_delete_workspaces" {
  description = "(Optional) Whether workspace administrators are permitted to delete workspaces with resources under management. If false, only organization owners may delete these workspaces. Defaults to `false`."
  type        = bool
  default     = false
}

variable "assessments_enforced" {
  description = "(Optional) Whether to force health assessments (drift detection) on all eligible workspaces or allow workspaces to set their own preferences. Default to `true`."
  type        = bool
  default     = true
}

variable "collaborator_auth_policy" {
  description = "(Optional) Authentication policy. Valid values are `password` or `two_factor_mandatory`. Default to `two_factor_mandatory`."
  type        = string
  default     = "two_factor_mandatory"

  validation {
    condition     = contains(["password", "two_factor_mandatory"], var.collaborator_auth_policy) ? true : false
    error_message = "Valid values are \"password\" or \"two_factor_mandatory\"."
  }
}

variable "cost_estimation_enabled" {
  description = "(Optional) Whether or not the cost estimation feature is enabled for all workspaces in the organization. Defaults to `true`."
  type        = bool
  default     = true
}

variable "default_agent_pool_id" {
  description = "(Optional) The ID of an agent pool to assign to the workspace. Requires `default_execution_mode` to be set to `agent`. This value must not be provided if `default_execution_mode` is set to any other value."
  type        = string
  default     = null
}

variable "default_execution_mode" {
  description = " (Optional) Which execution mode to use as the default for all workspaces in the organization. Valid values are `remote`, `local` or `agent`. Default to `remote`."
  type        = string
  default     = "remote"

  validation {
    condition     = contains(["remote", "local", "agent"], var.default_execution_mode) ? true : false
    error_message = "Valid values are \"remote\", \"local\", or \"agent\"."
  }
}

variable "owners_team_saml_role_id" {
  description = "(Optional) The name of the \"owners\" team."
  type        = string
  default     = null
}

variable "send_passing_statuses_for_untriggered_speculative_plans" {
  description = "(Optional) Whether or not to send VCS status updates for untriggered speculative plans. This can be useful if large numbers of untriggered workspaces are exhausting request limits for connected version control service providers like GitHub. Defaults to `false`."
  type        = bool
  default     = false
}

variable "session_remember_minutes" {
  description = "(Optional) Session expiration. Defaults to `20160`."
  type        = number
  default     = null
}


variable "session_timeout_minutes" {
  description = "(Optional) Session timeout after inactivity. Defaults to `20160`."
  type        = number
  default     = null
}

variable "speculative_plan_management_enabled" {
  description = "(Optional) Whether or not to enable Speculative Plan Management. If true, pending VCS-triggered speculative plans from outdated commits will be cancelled if a newer commit is pushed to the same branch. default to `true`."
  type        = bool
  default     = true
}

variable "teams" {
  description = <<EOT
  (Optional) The teams block supports the following:
    name                         : (Required) Name of the team. 
    organization_access          : (Optional) The organization_access supports the following:
      access_secret_teams        : (Optional) Allow members access to secret teams up to the level of permissions granted by their team permissions setting.
      manage_agent_pools         : (Optional) Allow members to create, edit, and delete agent pools within their organization.
      manage_membership          : (Optional) Allow members to add/remove users from the organization, and to add/remove users from visible teams.
      manage_modules             : (Optional) Allow members to publish and delete modules in the organization's private registry.
      manage_organization_access : (Optional) Allow members to update the organization access settings of teams.
      manage_policies            : (Optional) Allows members to create, edit, and delete the organization's Sentinel policies.
      manage_policy_overrides    : (Optional) Allows members to override soft-mandatory policy checks.
      manage_projects            : (Optional) Allow members to create and administrate all projects within the organization.
      manage_providers           : (Optional) Allow members to publish and delete providers in the organization's private registry.
      manage_run_tasks           : (Optional) Allow members to create, edit, and delete the organization's run tasks.
      manage_teams               : (Optional) Allow members to create, update, and delete teams.
      manage_vcs_settings        : (Optional) Allows members to manage the organization's VCS Providers and SSH keys.
      manage_workspaces          : (Optional) Allows members to create and administrate all workspaces within the organization.
      read_projects              : (Optional) Allow members to view all projects within the organization. Requires read_workspaces to be set to true.
      read_workspaces            : (Optional) Allow members to view all workspaces in this organization.
    sso_team_id                  : (Optional) Unique Identifier to control team membership via SAML.
    token                        : (Optional) If set to `true`, a team token will be generated.
    token_description            : (Optional) The token's description, which must be unique per team. Required if creating multiple tokens for a single team.
    token_expired_at             : (Optional) The token's expiration date. The expiration date must be a date/time string in RFC3339 format (e.g., '2024-12-31T23:59:59Z'). If no expiration date is supplied, the expiration date will default to null and never expire.
    token_force_regenerate       : (Optional) If set to `true`, a new token will be generated even if a token already exists. This will invalidate the existing token!
    visibility                   : (Optional) The visibility of the team (`secret` or `organization`).
  EOT
  type = list(object({
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
  default = []

  validation {
    condition     = length([for team in var.teams : team.organization_access != null ? team.organization_access.read_projects != false && team.organization_access.manage_projects != false ? false : true : true]) == length(var.teams)
    error_message = "Project access must be `read` or `manage`."
  }

  validation {
    condition     = length([for team in var.teams : team.organization_access != null ? team.organization_access.read_workspaces != false && team.organization_access.manage_workspaces != false ? false : true : true]) == length(var.teams)
    error_message = "Workspaces access must be `read` or `manage`."
  }

  validation {
    condition     = length([for team in var.teams : team.organization_access != null ? team.organization_access.manage_projects == true && team.organization_access.manage_workspaces != true ? false : true : true]) == length(var.teams)
    error_message = "`manage_projects` requires `manage_workspaces` to be set to `true`."
  }
  validation {
    condition     = length([for team in var.teams : team.token_expired_at != null ? length(regexall("^((?:(\\d{4}-\\d{2}-\\d{2})T(\\d{2}:\\d{2}:\\d{2}))Z)$", team.token_expired_at)) > 0 ? true : false : true]) == length(var.teams)
    error_message = "The expiration date must be a date/time string in RFC3339 format (e.g., '2024-12-31T23:59:59Z')."
  }
  validation {
    condition     = length([for team in var.teams : contains(["secret", "organization"], team.visibility)]) == length(var.teams)
    error_message = "Valid values for `visibility` is \"secret\" or \"organization\"."
  }
}