class RenamePublicColumn < ActiveRecord::Migration
  def change
    remove_column :goals, :public
    add_column :goals, :personal, :boolean, default: false
  end
end
