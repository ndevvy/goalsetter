class AddColumnsToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :public, :boolean, default: true
    add_column :goals, :completed, :boolean, default: false
  end
end
