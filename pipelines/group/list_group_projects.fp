pipeline "list_group_projects" {
  title       = "List Group Projects"
  description = "List group projects."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "group_id" {
    type        = string
    description = "The ID or URL-encoded path of the group owned by the authenticated user."
  }

  param "visibility" {
    type        = string
    description = "Limit by visibility public, internal, or private."
    optional    = true
  }

  step "http" "list_group_projects" {
    method = "get"
    url    = param.visibility != null ? "https://gitlab.com/api/v4/groups/${param.group_id}/projects?visibility=${param.visibility}&page=1&per_page=100" : "https://gitlab.com/api/v4/groups/${param.group_id}/projects?page=1&per_page=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${credential.gitlab[param.cred].token}"
    }

    loop {
      until = result.response_headers["X-Next-Page"] == ""
      url   = param.visibility != null ? "https://gitlab.com/api/v4/groups/${param.group_id}/projects?visibility=${param.visibility}&page=${result.response_headers["X-Next-Page"]}&per_page=100" : "https://gitlab.com/api/v4/groups/${param.group_id}/projects?page=${result.response_headers["X-Next-Page"]}&per_page=100"
    }

  }

  output "group_projects" {
    description = "A list of group projects."
    value       = flatten([for page, projects in step.http.list_group_projects : projects.response_body])
  }
}

