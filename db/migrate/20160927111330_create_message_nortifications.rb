class CreateMessageNortifications < ActiveRecord::Migration
  def change
    create_table :message_nortifications do |t|
      t.boolean :read, default: false
      t.references :user, index: true, foreign_key: true
      t.references :conversation, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end