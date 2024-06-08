class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :summary
      t.string :priority
      t.string :link
      t.string :status
      t.string :jira_key

      t.timestamps
    end
  end
end
