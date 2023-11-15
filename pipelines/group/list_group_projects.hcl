pipeline "list_group_projects" {
  title       = "List Group Projects"
  description = "List Group Projects."

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "group_id" {
    type        = string
    description = "Group ID"
  }

  param "visibility" {
    type        = string
    description = "Limit by visibility public, internal, or private."
    optional    = true
  }

  step "http" "list_group_projects" {
    method = "get"
    url    = param.visibility != null ? "https://gitlab.com/api/v4/groups/${param.group_id}/projects?visibility=${param.visibility}" : "https://gitlab.com/api/v4/groups/${param.group_id}/projects"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }
  }

  output "group_projects" {
    description = "Details of Group Projects."
    value       = step.http.list_group_projects.response_body
  }
}

