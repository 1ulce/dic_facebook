class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @users = @conversation.users
    @messages = @conversation.messages
    # if @messages.length > 10
    #   @over_ten = true
    #   @messages = @messages[-10..-1]
    # end

    # if params[:m]
    #   @over_ten = false
    #   @messages = @conversation.messages
    # end

    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end
    @message = @conversation.messages.build
    respond_to do |format|
      format.html { render 'index' }
      format.js { render :index }
    end
  end

  def create
    @message = @conversation.messages.build(message_params)
    @messages = @conversation.messages
    if @message.save
      render "create"
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :user_id)
    end

end
