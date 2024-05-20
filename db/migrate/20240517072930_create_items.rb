class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :collection,null: false,foreign_key: true
      t.string:name
      t.string:tags, array: true,default: []

      t.timestamps
    end
  end
end
