class AddCategoryToCollections < ActiveRecord::Migration[7.1]
  def change
    
    add_column :collections, :category, :string, default: 'other'
    Collection.where(category: nil).update_all(category: 'other')
  end
end
