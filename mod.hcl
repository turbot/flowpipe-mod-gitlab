mod "gitlab_mod" {
  title         = "GitLab"
  description   = "GitLab mod containing standard pipelines and triggers."
  color         = "#FCA121"
  documentation = file("./docs/index.md")
  icon          = "/images/flowpipe/mods/turbot/gitlab.svg"
  categories    = ["gitlab"]

  opengraph {
    title       = "GitLab"
    description = "GitLab mod containing standard pipelines and triggers."
    image       = "/images/flowpipe/mods/turbot/gitlab-social-graphic.png"
  }
}
