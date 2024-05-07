class AddRoleAndLightThemeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :users, :light_theme, :boolean, default: true
  end
end
