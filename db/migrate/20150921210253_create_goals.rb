class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.integer :user_id, null: false, index: true
      t.text :text, null: false

      t.timestamps null: false
    end
  end
end
