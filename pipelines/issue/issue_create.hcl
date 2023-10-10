// usage: flowpipe pipeline run issue_create
pipeline "issue_create" {
  description = "Create an issue in a project."

  param "token" {
    type    = string
    default = var.token
  }

  param "project_id" {
    type    = string
  }

  param "issue_title" {
    type    = string
    default = "My new issue"
  }

  param "issue_description" {
    type    = string
    default = "New issue!"
  }

  step "http" "issue_create" {
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

  output "issue_id" {
    value = jsondecode(step.http.issue_create.response_body).iid
  }
  output "response_body" {
    value = step.http.project_create.response_body
  }
  output "response_headers" {
    value = step.http.issue_create.response_headers
  }
  output "status_code" {
    value = step.http.issue_create.status_code
  }
}
