class AddUserToTickets < ActiveRecord::Migration[7.1]
  def change
    
    add_reference :tickets, :user, foreign_key: true
  end
end
