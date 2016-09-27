class CreateFriendNortifications < ActiveRecord::Migration
  def change
    create_table :friend_nortifications do |t|
        t.integer :user_id
        t.integer :follower_id
        t.boolean :read, default: false
      t.timestamps null: false
    end
    add_index :friend_nortifications, :follower_id
    add_index :friend_nortifications, :user_id
  end
end
