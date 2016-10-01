class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # コメントが入ったらnortification作る
    # @notification = @comment.notifications.build(user_id: @topic.user.id )

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
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
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @topic = Topic.find(params[:topic_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    if @comment.update(comment_params)
      redirect_to root_path, notice: "コメントを編集しました！"
    else
      render action: 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_path(@topic), notice: 'コメントを削除しました。' }
      format.json { render :show, status: :created, location: @comment }
      format.js { render :index }
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
