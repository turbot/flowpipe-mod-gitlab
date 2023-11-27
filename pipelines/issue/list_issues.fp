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
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues?page=1&per_page=100"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }

    loop {
      until = result.response_headers["X-Next-Page"] == ""
      url   = "https://gitlab.com/api/v4/projects/${param.project_id}/issues?page=${result.response_headers["X-Next-Page"]}&per_page=100"
    }
  }

  output "issues" {
    description = "A list of issues."
    value       = flatten([for page, issues in step.http.list_issues : issues.response_body])
  }
}
