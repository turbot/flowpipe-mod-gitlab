pipeline "get_project" {
  title       = "Get Project"
  description = "Get a project by ID."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  step "http" "get_project" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${credential.gitlab[param.cred].token}"
    }
  }

  output "project" {
    description = "Project details."
    value       = step.http.get_project.response_body
  }
}
