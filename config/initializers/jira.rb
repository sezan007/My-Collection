JIRA_OPTIONS = {
  username: ENV['JIRA_USERNAME'],
  password: ENV['JIRA_API_TOKEN'],
  site: 'https://my-collection-course-project.atlassian.net',
  context_path: '',
  auth_type: :basic
}

JIRA_CLIENT = JIRA::Client.new(JIRA_OPTIONS)
