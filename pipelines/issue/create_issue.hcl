pipeline "create_issue" {
  title       = "Create Issue"
  description = "Create a new issue."

  param "token" {
    type        = string
    description = "GitHub personal access token."
    default     = var.token
  }

  param "project_id" {
    type        = string
    description = "Project ID to create the new issue in."
  }

  param "issue_title" {
    type        = string
    description = "New issue title."
  }

  param "issue_description" {
    type        = string
    description = "New issue description."
  }

  step "http" "create_issue" {
    method = "post"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.token}"
    }

    request_body = jsonencode({
      title = "${param.issue_title}"
      description = "${param.issue_description}"
    })
  }

  output "issue" {
    description = "New issue details."
    value       = step.http.create_issue.response_body
  }
}
