class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]
  
  def index
    @topics = Topic.all
    @topic = Topic.new
    @user = current_user
    @users = User.all
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topics_params)
    @topics = Topic.all
    # if @topic.save
    #   redirect_to topics_path, notice: "投稿しました！"
    # else
    #   redirect_to topics_path
    # end
    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: '投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
        format.js { render :index }
        # コメントが入ったらpushする
        # unless @comment.topic.user_id == current_user.id
        #   Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
        #     message: 'あなたの作成したブログにコメントが付きました'
        #   })
        # end
        # Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
        #   uncreate_count: Notification.where(user_id: @comment.topic.user.id).count
        # })
      else
        format.html { redirect_to topics_path }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def update
    if @topic.update(topics_params)
      redirect_to topics_path, notice: "ツイートを編集しました！"
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "ツイートを削除しました！"
  end
  def confirm
    @topic = Topic.new(topics_params)
    render :new if @topic.invalid?
  end
  private
    def topics_params
      params.require(:topic).permit(:content)
    end
    def set_topic
      @topic = Topic.find(params[:id])
    end
end
