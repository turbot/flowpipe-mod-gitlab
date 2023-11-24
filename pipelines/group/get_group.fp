pipeline "get_group" {
  title       = "Get Group"
  description = "Get group details."

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "group_id" {
    type        = string
    description = "	The ID or URL-encoded path of the group owned by the authenticated user."
  }

  #  Deprecated, scheduled for removal in API v5.
  param "with_projects" {
    type        = bool
    description = "Include group projects."
    default     = false
  }

  step "http" "get_group" {
    method = "get"
    url    = "https://gitlab.com/api/v4/groups/${param.group_id}?with_projects=${param.with_projects}"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }
  }

  output "group" {
    description = "Group details."
    value       = step.http.get_group.response_body
  }
}
