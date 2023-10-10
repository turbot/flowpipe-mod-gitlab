variable "token" {
  type        = string
  description = "The GitLab personal access token to authenticate to the GitLab APIs, e.g., `glpat-ABC123_456`. Please see https://docs.gitlab.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens for more information. Can also be set with the P_VAR_token environment variable."
}

variable "slack_token" {
  description = "Slack app token used to authenticate to your Slack workspace."
  type        = string
  default     = ""
}
