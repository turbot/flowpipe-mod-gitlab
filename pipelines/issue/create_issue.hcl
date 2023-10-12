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
    description = "The ID of the project."
  }

  param "title" {
    type        = string
    description = "The title of an issue."
  }

  param "description" {
    type        = string
    description = "The description of an issue. Limited to 1,048,576 characters."
  }

  param "due_date" {
    type        = string
    description = "The due date. Date time string in the format YYYY-MM-DD, for example 2016-03-11."
    optional    = true
  }

  step "http" "create_issue" {
    method = "post"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }

    request_body = jsonencode({
      title       = "${param.title}"
      description = "${param.description}"
      due_date    = "${param.due_date}"
    })
  }

  output "issue" {
    description = "Issue details."
    value       = step.http.create_issue.response_body
  }
}
