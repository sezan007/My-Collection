class AssignTicketsToUser < ActiveRecord::Migration[7.1]
  def change
    user_id =  User.order(created_at: :desc).first.id# Replace 1 with the actual user ID
    
    # Find all existing tickets
    tickets = Ticket.all

    # Assign the user ID to each ticket
    tickets.each do |ticket|
      ticket.update(user_id: user_id)
    end
  end
end
