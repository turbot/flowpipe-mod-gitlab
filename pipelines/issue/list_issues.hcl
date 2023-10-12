pipeline "list_issues" {
  title       = "List Issues"
  description = "List issues."

  param "token" {
    type        = string
    description = "GitHub personal access token."
    default     = var.token
  }

  param "project_id" {
    type        = string
    description = "Project ID to list issues in."
  }

  step "http" "list_issues" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.token}"
    }

    request_body = jsonencode({
      search = "hello"
    })
  }

  output "issues" {
    description = "A list of issues."
    value       = step.http.list_issues.response_body
  }
}
