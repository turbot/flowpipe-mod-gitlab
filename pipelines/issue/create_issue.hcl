pipeline "create_issue" {
  title       = "Create Issue"
  description = "Create a new issue."

  param "access_token" {
    type        = string
    description = "GitLab personal, project, or group access token."
    default     = var.access_token
  }

  param "project_id" {
    type        = string
    description = "Project ID to create the new issue in."
  }

  param "title" {
    type        = string
    description = "New issue title."
  }

  param "description" {
    type        = string
    description = "New issue description."
  }

  step "http" "create_issue" {
    method = "post"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }

    request_body = jsonencode({
      title = "${param.title}"
      description = "${param.description}"
    })
  }

  output "issue" {
    description = "New issue details."
    value       = step.http.create_issue.response_body
  }
}
