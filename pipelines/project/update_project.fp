pipeline "update_project" {
  title       = "Update Project"
  description = "Update a project by ID."

  tags = {
    type = "featured"
  }

  param "conn" {
    type        = connection.gitlab
    description = local.conn_param_description
    default     = connection.gitlab.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "name" {
    type        = string
    description = "The name of the project."
    optional    = true
  }

  param "visibility" {
    type        = string
    description = "Limit by visibility public, internal, or private."
    optional    = true
  }

  param "default_branch" {
    type        = string
    description = "The default branch name."
    optional    = true
  }

  param "description" {
    type        = string
    description = "Short project description."
    optional    = true
  }

  step "http" "update_project" {
    method = "put"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.conn.token}"
    }

    request_body = jsonencode({ for name, value in param : name => value if value != null })
  }

  output "project" {
    description = "Project details."
    value       = step.http.update_project.response_body
  }
}
