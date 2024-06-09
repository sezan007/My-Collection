namespace :jira do
    desc "Fetch and log Jira metadata"
    task fetch_metadata: :environment do
      jira_client = JIRA_CLIENT
  
      begin
        response = jira_client.get('/rest/api/3/issue/createmeta?expand=projects.issuetypes.fields')
        metadata = JSON.parse(response.body)
  
        # Log the details of customfield_10039
        metadata['projects'].each do |project|
          project['issuetypes'].each do |issuetype|
            issuetype['fields'].each do |field_key, field_details|
              if field_key == 'customfield_10039'
                puts JSON.pretty_generate(field_details)
              end
            end
          end
        end
      rescue JIRA::HTTPError => e
        puts "Failed to fetch Jira metadata: #{e.response.body}"
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
      end
    end
  end
  