pipeline "list_issues_by_query" {
  title       = "List Issues By Steampipe Query"
  description = "List issues using a Steampipe query."

  param "project_id" {
    type        = string
    description = local.project_id_param_description
  }

  step "query" "list_issues_by_query" {
    connection_string = "postgres://steampipe@localhost:9193/steampipe"
    sql               = <<EOQ
      select
        title,
        id
      from
        gitlab_issue
      where
        project_id = ${param.project_id}
      EOQ
  }

  output "issues" {
    description = "A list of issues."
    value       = step.query.list_issues_by_query.rows
  }
}
