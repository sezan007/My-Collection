class MoveBodytoDescription < ActiveRecord::Migration[7.1]
  def change
    Collection.all.find_each do |collection|
      collection.update(description: collection.body)
    end
    remove_column :collections,:body
  end
end
