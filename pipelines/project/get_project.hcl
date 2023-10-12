pipeline "get_project" {
  title       = "Get Project"
  description = "Get a project by ID."

  param "access_token" {
    type        = string
    description = "GitLab personal, project, or group access token."
    default     = var.access_token
  }

  param "project_id" {
    type        = string
    description = "Project ID to get."
  }

  step "http" "get_project" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }
  }

  output "project" {
    description = "Project details."
    value = step.http.get_project.response_body
  }
}
