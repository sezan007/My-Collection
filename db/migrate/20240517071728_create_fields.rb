class CreateFields < ActiveRecord::Migration[7.1]
  def change
    create_table :fields do |t|
      t.references :collection,null: false, foreign_key: true
      t.string:name
      t.string:field_typy
      t.timestamps
    end
  end
end
