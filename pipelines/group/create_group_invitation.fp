pipeline "create_group_invitation" {
  title       = "Create Group Invitation"
  description = "Adds a new member."

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "group_id" {
    type        = string
    description = "The ID or URL-encoded path of the group owned by the authenticated user."
  }

  param "email" {
    type        = string
    description = "The email of the new member."
  }

  param "access_level" {
    type = string
    # https://docs.gitlab.com/ee/api/members.html#valid-access-levels
    description = <<EOD
      "A valid access level (defaults: 30, the Developer role)."
        * No access (0)
        * Minimal access (5) (Introduced in GitLab 13.5.)
        * Guest (10)
        * Reporter (20)
        * Developer (30)
        * Maintainer (40)
        * Owner (50). Valid for projects in GitLab 14.9 and later.
    EOD
  }

  step "http" "create_group_invitation" {
    method = "post"
    url    = "https://gitlab.com/api/v4/groups/${param.group_id}/invitations"


    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Bearer ${param.access_token}"
    }

    request_body = jsonencode({
      access_level = param.access_level
      email        = param.email
    })
  }

  output "invitation" {
    description = "Invitation details."
    value       = step.http.create_group_invitation.response_body
  }
}
