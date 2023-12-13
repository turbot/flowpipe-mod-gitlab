pipeline "list_projects" {
  title       = "List Projects"
  description = "List projects."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "membership" {
    type        = bool
    description = "Limit by projects that the current user is a member of."
    default     = true
  }

  param "owned" {
    type        = bool
    description = "Limit by projects explicitly owned by the current user."
    optional    = true
  }

  param "visibility" {
    type        = string
    description = "Limit by visibility public, internal, or private."
    optional    = true
  }

  step "http" "list_projects" {
    method = "get"
    url    = "https://gitlab.com/api/v4/projects?page=1&per_page=100&${join("&", [for name, value in param : "${name}=${value}" if value != null])}"

    loop {
      until = result.response_headers["X-Next-Page"] == ""
      url   = "https://gitlab.com/api/v4/projects?page=${result.response_headers["X-Next-Page"]}&per_page=100&${join("&", [for name, value in param : "${name}=${value}" if value != null])}"
    }
  }

  output "projects" {
    description = "A list of projects."
    value       = flatten([for page, projects in step.http.list_projects : projects.response_body])
  }
}
