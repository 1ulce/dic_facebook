class TopController < ApplicationController
  def index
    if user_signed_in?
      redirect_to topics_path
    end
    @user = User.new
  end
end