resource "tfe_team" "this" {

  name         = var.name
  sso_team_id  = var.sso_team_id
  organization = var.organization

  dynamic "organization_access" {
    for_each = var.organization_access != null ? [true] : []
    content {
      access_secret_teams        = var.organization_access.access_secret_teams
      manage_agent_pools         = var.organization_access.manage_agent_pools
      manage_membership          = var.organization_access.manage_membership
      manage_modules             = var.organization_access.manage_modules
      manage_organization_access = var.organization_access.manage_organization_access
      manage_policies            = var.organization_access.manage_policies
      manage_policy_overrides    = var.organization_access.manage_policy_overrides
      manage_projects            = var.organization_access.manage_projects
      manage_providers           = var.organization_access.manage_providers
      manage_run_tasks           = var.organization_access.manage_run_tasks
      manage_teams               = var.organization_access.manage_teams
      manage_vcs_settings        = var.organization_access.manage_vcs_settings
      manage_workspaces          = var.organization_access.manage_workspaces
      read_projects              = var.organization_access.read_projects
      read_workspaces            = var.organization_access.read_workspaces
    }
  }

  visibility = var.visibility

}

resource "tfe_team_token" "this" {

  count = var.token ? 1 : 0

  team_id          = tfe_team.this.id
  description      = var.token_description
  expired_at       = var.token_expired_at
  force_regenerate = var.token_force_regenerate

}

resource "tfe_team_organization_members" "this" {

  count = length(var.organization_membership_ids) > 0 ? 1 : 0

  team_id                     = tfe_team.this.id
  organization_membership_ids = var.organization_membership_ids

}
