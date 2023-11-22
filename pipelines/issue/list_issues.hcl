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

  param "page" {
    type        = number
    description = local.page_param_description
    default     = 1
  }

  param "per_page" {
    type        = number
    description = local.per_page_param_description
    default     = 20
  }

  step "http" "list_issues" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues?page=${param.page}&per_page=${param.per_page}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }

    loop {
      until = result.response_headers["X-Next-Page"] == ""
      url   = "https://gitlab.com/api/v4/projects/${param.project_id}/issues?page=${result.response_headers["X-Next-Page"]}&per_page=${param.per_page}"
    }
  }

  output "issues" {
    description = "A list of issues."
    value       = flatten([for page, issues in step.http.list_issues : issues.response_body])
  }
}
