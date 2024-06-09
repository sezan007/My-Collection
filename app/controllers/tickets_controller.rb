class TicketsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status = 'Opened'
    jira_user = ensure_jira_user_exists(current_user.email, current_user.name)
    # @ticket.collection = current_user.collection # assuming a user has a collection association
    # binding.b
    if @ticket.save
      jira_ticket = create_jira_ticket(@ticket,jira_user["accountId"])
      if jira_ticket
        # binding.b
        @ticket.update(jira_key: jira_ticket.key)
        redirect_to tickets_index_path, notice: 'Ticket was successfully created.'
      else
        @ticket.destroy
        render :new, notice: 'Failed to create Jira ticket.'
      end
    else
      render :new
    end
  end

  def index
    @tickets =Ticket.all
  end

  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :link)
  end
  def ensure_jira_user_exists(email, display_name)
    response = JIRA_CLIENT.get("/rest/api/3/user/search?query=#{email}")
    users = JSON.parse(response.body)
    
    if users.any?
      users.first
    else
      new_user = {
        "emailAddress" => "#{email}",
        "displayName" => "#{display_name}",
        "products" => ["jira-software" ] # Adjust as needed
      }

      response = JIRA_CLIENT.post('/rest/api/3/user', new_user.to_json)
      JSON.parse(response.body)
    end
  rescue JIRA::HTTPError => e
    Rails.logger.error "Jira user creation failed: #{e.response.body}"
    nil
  end
  def create_jira_ticket(ticket,accountId)
    
    issue = JIRA_CLIENT.Issue.build
    issue.save({
      'fields' => {
        'project' => { 'key' => 'MYC' },
        'summary' => "#{ticket.summary }",
        'customfield_10036' => "#{ticket.priority}",
        'customfield_10035' => "#{ticket.link}",
        'reporter' => { 'id' => "#{accountId}" },
        'customfield_10039' =>  [{ 'accountId' => "#{accountId}"}] ,
        
        # 'description' => "Reported by #{current_user.email}\nLink: #{ticket.link}",
        'issuetype' => { 'id' => '10015'
                        }
        

      }
    })
    issue
    binding.b
  rescue StandardError => e
    Rails.logger.error "Jira ticket creation failed: #{e.message}"
    nil
  end
end
