// usage: flowpipe pipeline run issue_list
pipeline "issue_list" {
  description = "List project issues."

  param "token" {
    type    = string
    default = var.token
  }

  param "project_id" {
    type = string
  }

  step "http" "issue_list" {
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

  output "response_body" {
    value = step.http.issue_list.response_body
  }
  output "response_headers" {
    value = step.http.issue_list.response_headers
  }
  output "status_code" {
    value = step.http.issue_list.status_code
  }
}
