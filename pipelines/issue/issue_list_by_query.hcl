// usage: flowpipe pipeline run issue_list_by_query
pipeline "issue_list_by_query" {
  description = "List project issues by query."

  param "token" {
    type    = string
    default = var.token
  }

  param "project_id" {
    type = string
  }

  step "query" "issue_list_by_query" {
    connection_string = "postgres://steampipe@localhost:9193/steampipe"
    sql = <<EOQ
      select
        title,
        id
      from
        gitlab_issue
      where
        project_id = ${param.project_id}
      EOQ
    }

  output "rows" {
    value = step.query.issue_list_by_query.rows
  }
}
