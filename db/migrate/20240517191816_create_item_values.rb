class CreateItemValues < ActiveRecord::Migration[7.1]
  def change
    create_table :item_values do |t|
      t.references:item,null:false,foreign_key:true
      t.references:field,null:false,foreign_key:true
      t.string:value

      t.timestamps
    end
  end
end
