# The following code manage the organization settins.

resource "tfe_organization" "this" {
  email                                                   = var.organization_email
  name                                                    = var.organization_name
  aggregated_commit_status_enabled                        = var.aggregated_commit_status_enabled
  allow_force_delete_workspaces                           = var.allow_force_delete_workspaces
  assessments_enforced                                    = var.assessments_enforced
  collaborator_auth_policy                                = var.collaborator_auth_policy
  cost_estimation_enabled                                 = var.cost_estimation_enabled
  owners_team_saml_role_id                                = var.owners_team_saml_role_id
  send_passing_statuses_for_untriggered_speculative_plans = var.send_passing_statuses_for_untriggered_speculative_plans
  session_remember_minutes                                = var.session_remember_minutes
  session_timeout_minutes                                 = var.session_timeout_minutes
  speculative_plan_management_enabled                     = var.speculative_plan_management_enabled
}

# The following code block must be use to import de organization into terraform.  Once it's done, you can remove it.

# import {
#   id = ""
#   to = tfe_organization.this
# }

# The following code block is use to set the default execution mode of an organization. 

resource "tfe_organization_default_settings" "this" {
  # default_agent_pool_id  = var.default_agent_pool_id
  default_execution_mode = var.default_execution_mode
  organization           = tfe_organization.this.name

  lifecycle {
    precondition {
      condition     = var.default_agent_pool_id != null ? var.default_execution_mode == "agent" ? true : false : true
      error_message = "Requires `default_execution_mode` to be set to agent if `default_agent_pool_id` is set."
    }
  }
}

# The following code block is use to create and manage agent pools avaiable at the organization level.

module "agent_pool" {
  source            = "./modules/tfe_agent"
  for_each          = toset(var.agent_pools)
  name              = each.value
  organization      = tfe_organization.this.name
  token_description = ["token"]
}

# The following code block is use to create and manage team at the organization level.

module "teams" {
  source                 = "./modules/tfe_team"
  for_each               = nonsensitive({ for team in var.teams : team.name => team })
  name                   = each.value.name
  organization           = tfe_organization.this.name
  organization_access    = try(each.value.organization_access, null)
  sso_team_id            = try(each.value.sso_team_id, null)
  token                  = try(each.value.token, false)
  token_expired_at       = try(each.value.token_expired_at, null)
  token_force_regenerate = try(each.value.token_force_regenerate, null)
  visibility             = try(each.value.visibility, "organization")
}