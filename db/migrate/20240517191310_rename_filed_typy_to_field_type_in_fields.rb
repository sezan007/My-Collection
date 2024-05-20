class RenameFiledTypyToFieldTypeInFields < ActiveRecord::Migration[7.1]
  def change
    rename_column :fields,:field_typy,:field_type
  end
end
