class AddCascadeDeleteToItemValues < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :item_values, :fields
  
    add_foreign_key :item_values, :fields, on_delete: :cascade
  end

  def down
 
    remove_foreign_key :item_values, :fields
    add_foreign_key :item_values, :fields
  end
end