class RenameTypeToGroupType < ActiveRecord::Migration[7.0]
  def change
    rename_column :groups, :type, :group_type
  end
end
