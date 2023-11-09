pipeline "list_projects" {
  title       = "List Projects"
  description = "List projects."

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "membership" {
    type        = bool
    description = "Limit by projects that the current user is a member of."
    default     = true
  }

  param "owned" {
    type        = bool
    description = "Limit by projects explicitly owned by the current user."
    optional    = true
  }

  param "visibility" {
    type        = string
    description = "Limit by visibility public, internal, or private."
    optional    = true
  }


  step "http" "list_projects" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }

    request_body = jsonencode({ for name, value in param : name => value if value != null })
  }

  output "projects" {
    description = "A list of projects."
    value = step.http.list_projects.response_body
  }
}
