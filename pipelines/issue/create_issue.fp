pipeline "create_issue" {
  title       = "Create Issue"
  description = "Create a new issue."

  tags = {
    type = "featured"
  }

  param "conn" {
    type        = connection.gitlab
    description = local.conn_param_description
    default     = connection.gitlab.default
  }

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  param "assignee_id" {
    type        = number
    description = "The ID of the user to assign the issue to. Only appears on GitLab Free."
    optional    = true
  }

  param "assignee_ids" {
    type        = list(number)
    description = "The IDs of the users to assign the issue to."
    optional    = true
  }

  param "confidential" {
    type        = bool
    description = "Set an issue to be confidential. Default is false."
    optional    = true
  }

  param "created_at" {
    type        = string
    description = "When the issue was created. Date time string, ISO 8601 formatted, for example 2016-03-11T03:45:40Z. Requires administrator or project/group owner rights."
    optional    = true
  }

  param "description" {
    type        = string
    description = "The description of an issue. Limited to 1,048,576 characters."
    optional    = true
  }

  param "discussion_to_resolve" {
    type        = string
    description = "The ID of a discussion to resolve. This fills out the issue with a default description and marks the discussion as resolved. Use in combination with merge_request_to_resolve_discussions_of."
    optional    = true
  }

  param "due_date" {
    type        = string
    description = "The due date. Date time string in the format YYYY-MM-DD, for example 2016-03-11."
    optional    = true
  }

  param "epic_id" {
    type        = number
    description = "ID of the epic to add the issue to. Valid values are greater than or equal to 0."
    optional    = true
  }

  param "iid" {
    type        = number
    description = "The internal ID of the project's issue (requires administrator or project owner rights)."
    optional    = true
  }

  param "issue_type" {
    type        = string
    description = "The type of issue. One of issue, incident, or test_case. Default is issue."
    optional    = true
  }

  param "labels" {
    type        = list(string)
    description = "Comma-separated label names for an issue."
    optional    = true
  }

  param "merge_request_to_resolve_discussions_of" {
    type        = number
    description = "The IID of a merge request in which to resolve all issues. This fills out the issue with a default description and marks all discussions as resolved. When passing a description or title, these values take precedence over the default values."
    optional    = true
  }

  param "milestone_id" {
    type        = number
    description = "The global ID of a milestone to assign an issue. To find the milestone_id associated with a milestone, view an issue with the milestone assigned and use the API to retrieve the issue's details."
    optional    = true
  }

  param "title" {
    type        = string
    description = "The title of an issue."
  }

  param "weight" {
    type        = number
    description = "The weight of the issue. Valid values are greater than or equal to 0."
    optional    = true
  }

  step "http" "create_issue" {
    method = "post"
    url    = "https://gitlab.com/api/v4/projects/${param.project_id}/issues"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.conn.token}"
    }

    request_body = jsonencode({ for name, value in param : name => value if value != null })
  }

  output "issue" {
    description = "Issue details."
    value       = step.http.create_issue.response_body
  }
}
