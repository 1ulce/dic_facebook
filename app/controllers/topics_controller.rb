class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]
  
  def index
    @user = current_user
    @friend = @user.friend
    @users = User.all
    @self_friends_id = [@user.id].push(@user.friend.map {|u| u.id}).flatten
    @topics = Topic.all.order(created_at: :desc)
    @topic = Topic.new(user_id: @user.id)
    @conversations = @user.conversations
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
    @topics = Topic.all.order(created_at: :desc)
    @user = current_user
    @self_friends_id = [@user.id].push(@user.friend.map {|u| u.id}).flatten
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
      redirect_to topics_path, notice: "投稿を編集しました！"
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "投稿を削除しました！"
  end
  def confirm
    @topic = Topic.new(topics_params)
    render :new if @topic.invalid?
  end
  private
    def topics_params
      params.require(:topic).permit(:content, :user_id)
    end
    def set_topic
      @topic = Topic.find(params[:id])
    end
end
