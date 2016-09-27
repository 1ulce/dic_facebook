class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
        t.text :content
        t.integer :user_id
        t.string :picture
      t.timestamps null: false
    end
  end
end
