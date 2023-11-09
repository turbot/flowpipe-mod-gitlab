pipeline "list_issues" {
  title       = "List Issues"
  description = "List issues."

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "project_id" {
    type        = string
    description = local.access_token_param_description
  }

  step "http" "list_issues" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
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
