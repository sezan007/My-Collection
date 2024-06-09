namespace :jira do
    desc "Check if a user exists in Jira and create if not"
    task check_user: :environment do
      jira_client = JIRA_CLIENT
      user_email = 'sezan@famil.com'
      display_name = 'Display Name for sezannaimul'
  
      begin
        # Perform a user search query using the email address
        response = jira_client.get('/rest/api/3/user/search?query=' + user_email)
        users = JSON.parse(response.body)
  
        if users.any?
          jira_user = users.first
          puts "User #{user_email} already exists in Jira with account #{jira_user}."
        else
          # User not found, create a new Jira user
          begin
            new_user = {
              "emailAddress" => "#{user_email}",
              "displayName" => "#{display_name}",
              "products" => ["jira-software"] # Specify the product access
            }
  
            response = jira_client.post('/rest/api/3/user', new_user.to_json)
            puts "User #{user_email} was not found and has been created."
            puts " account #{jira_user}."
          rescue JIRA::HTTPError => e
            puts "Failed to create user: #{e.response.body}"
          end
        end
      rescue JIRA::HTTPError => e
        puts "An error occurred: #{e.response.body}"
      rescue => e
        puts "An unexpected error occurred: #{e.message}"
      end
    end
  end
  