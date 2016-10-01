class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @conversations = current_user.conversations
  end

  def create
    @user = User.find(params["sender_id"])
    @recipient_user = User.find(params["recipient_id"])
    unless @user.friend.index(@recipient_user)
      redirect_to root_path
    end
    groups_user_ids = []
    user_ids = [@user.id, @recipient_user.id].sort!

    @user.conversations.each do |conv|
      groups_user_ids << conv.users.map do |user|
        user.id
      end
    end
    if n = groups_user_ids.index(user_ids)
      @conversation = @user.conversations[n]
    else
      title = @user.name + ", " + @recipient_user.name
      @conversation = Conversation.create(title: title)
      user_ids.each do |user_id|
        UserConversation.create(conversation_id: @conversation.id, user_id: user_id)
      end
      @conversation
    end
    respond_to do |format|
      format.html { redirect_to conversation_messages_path(@conversation) }
      format.js { redirect_to root_path }
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
