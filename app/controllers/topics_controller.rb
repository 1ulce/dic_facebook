class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]
  
  def index
    @topics = Topic.all
    @topic = Topic.new
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
    if @topic.save
      redirect_to topics_path, notice: "ツイートを作成しました！"
    else
      redirect_to topics_path
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
