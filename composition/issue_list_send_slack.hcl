pipeline "issue_list_send_slack" {

  param "gitlab_project_id" {
    type = string
  }

  step "pipeline" "issue_list_by_query" {
    pipeline = gitlab.pipeline.issue_list_by_query
    args = {
      project_id = "${param.gitlab_project_id}"
    }
  }

  step "pipeline" "post_message" {
    #pipeline = slack.pipeline.chat_post_message
    pipeline = gitlab.pipeline.chat_post_message
    args = {
      message = "List of issues:\n ${join("", [for issue in jsondecode(step.pipeline.issue_list_by_query.rows) : format("%s - %s\n", issue.id, issue.title)])}"
    }
  }

}
