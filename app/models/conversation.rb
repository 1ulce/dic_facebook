class Conversation < ActiveRecord::Base
  has_many :user_conversations, dependent: :destroy
  has_many :users, ->{order('id')}, through: :user_conversations, dependent: :destroy
  has_many :messages, dependent: :destroy
  # scope :between, -> (sender_id,recipient_id) do
  #   where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  # end

  # def target_user(current_user)
  #   if sender_id == current_user.id
  #     User.find(recipient_id)
  #   elsif recipient_id == current_user.id
  #     User.find(sender_id)
  #   end
  # end
end