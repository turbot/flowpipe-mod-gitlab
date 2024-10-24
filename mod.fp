mod "gitlab" {
  title         = "GitLab"
  description   = "Run pipelines to supercharge your GitLab workflows using Flowpipe."
  color         = "#FCA121"
  documentation = file("./README.md")
  icon          = "/images/mods/turbot/gitlab.svg"
  categories    = ["library", "software development"]

  opengraph {
    title       = "GitLab Mod for Flowpipe"
    description = "Run pipelines to supercharge your GitLab workflows using Flowpipe."
    image       = "/images/mods/turbot/gitlab-social-graphic.png"
  }

  require {
    flowpipe {
      min_version = "1.0.0"
    }
  }
}
