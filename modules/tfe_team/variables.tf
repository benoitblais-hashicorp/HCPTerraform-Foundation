variable "name" {
  description = "(Required) Name of the team."
  type        = string
}

variable "organization" {
  description = "(Required) Name of the organization. If omitted, organization must be defined in the provider config."
  type        = string
}

variable "organization_access" {
  description = <<EOT
  (Optional) Settings for the team's organization access.
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
  EOT
  type = object({
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
  default = null

  validation {
    condition     = var.organization_access != null ? var.organization_access.read_projects != false && var.organization_access.manage_projects != false ? false : true : true
    error_message = "Project access must be `read` or `manage`."
  }

  validation {
    condition     = var.organization_access != null ? var.organization_access.read_workspaces != false && var.organization_access.manage_workspaces != false ? false : true : true
    error_message = "Workspaces access must be `read` or `manage`."
  }

  validation {
    condition     = var.organization_access != null ? var.organization_access.manage_projects == true && var.organization_access.manage_workspaces != true ? false : true : true
    error_message = "`manage_projects` requires `manage_workspaces` to be set to `true`."
  }
}

variable "organization_membership_ids" {
  description = "(Required) IDs of organization memberships to be added."
  type        = list(string)
  default     = []
}

variable "sso_team_id" {
  description = "(Optional) Unique Identifier to control team membership via SAML."
  type        = string
  default     = null
}

variable "token" {
  description = "(Optional) If set to `true`, a team token will be generated."
  type        = bool
  default     = false
}

variable "token_description" {
  description = "(Optional) The token's description, which must be unique per team. Required if creating multiple tokens for a single team."
  type        = string
  default     = null
}

variable "token_expired_at" {
  description = "(Optional) The token's expiration date. The expiration date must be a date/time string in RFC3339 format (e.g., '2024-12-31T23:59:59Z'). If no expiration date is supplied, the expiration date will default to null and never expire."
  type        = string
  default     = null

  validation {
    condition     = var.token_expired_at != null ? length(regexall("^((?:(\\d{4}-\\d{2}-\\d{2})T(\\d{2}:\\d{2}:\\d{2}))Z)$", var.token_expired_at)) > 0 ? true : false : true
    error_message = "The expiration date must be a date/time string in RFC3339 format (e.g., '2024-12-31T23:59:59Z')."
  }
}

variable "token_force_regenerate" {
  description = "(Optional) If set to `true`, a new token will be generated even if a token already exists. This will invalidate the existing token!"
  type        = bool
  default     = false
}

variable "visibility" {
  description = "(Optional) The visibility of the team (`secret` or `organization`)."
  type        = string
  default     = "organization"

  validation {
    condition     = var.visibility != null ? contains(["secret", "organization"], var.visibility) ? true : false : true
    error_message = "Valid values are `secret` or `organization`."
  }
}
