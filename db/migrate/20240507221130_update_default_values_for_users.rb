class UpdateDefaultValuesForUsers < ActiveRecord::Migration[7.1]
  def up
    User.update_all(role: 0, light_theme: true)
  end
end
