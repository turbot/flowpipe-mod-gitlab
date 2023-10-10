// usage: flowpipe pipeline run project_get_by_id
pipeline "project_get_by_id" {
  description = "Get the details of a given project by the ID."

  param "token" {
    type    = string
    default = var.token
  }

  param "project_id" {
    type = string
  }

  step "http" "project_get_by_id" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.token}"
    }

  }

  output "project_name" {
    value = jsondecode(step.http.project_get_by_id.response_body).name
  }
  output "path_with_namespace" {
    value = jsondecode(step.http.project_get_by_id.response_body).path_with_namespace
  }
  output "response_body" {
    value = step.http.project_get_by_id.response_body
  }
  output "response_headers" {
    value = step.http.project_get_by_id.response_headers
  }
  output "status_code" {
    value = step.http.project_get_by_id.status_code
  }
}
