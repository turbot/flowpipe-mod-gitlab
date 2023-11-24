variable "access_token" {
  type        = string
  description = "GitLab personal, project, or group access token to authenticate to the API. Example: glpat-ABC123_456-789."
  # TODO: Add once supported
  #sensitive  = true
}
