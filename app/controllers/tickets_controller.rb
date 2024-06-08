class TicketsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status = 'Opened'
    # @ticket.collection = current_user.collection # assuming a user has a collection association

    if @ticket.save
      jira_ticket = create_jira_ticket(@ticket)
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

  def create_jira_ticket(ticket)
    issue = JIRA_CLIENT.Issue.build
    issue.save({
      'fields' => {
        'project' => { 'key' => 'MYC' },
        'summary' => "My Summary :#{ticket.summary }",
        'description' => "Reported by #{current_user.email}\nLink: #{ticket.link}",
        'issuetype' => { 'id' => '10005' }
      }
    })
    issue
  rescue StandardError => e
    Rails.logger.error "Jira ticket creation failed: #{e.message}"
    nil
  end
end
