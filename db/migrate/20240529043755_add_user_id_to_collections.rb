class AddUserIdToCollections < ActiveRecord::Migration[7.1]
  add_reference :collections, :user, foreign_key: { on_delete: :cascade }
    
  # Update existing records to set a default user
  Collection.update_all(user_id: User.first.id) # Assuming User.first is the default user

  # Change the column to null: false
  change_column_null :collections, :user_id, false
end
