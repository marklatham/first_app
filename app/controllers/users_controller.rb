class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    if current_user.is_admin? or current_user == @user
      @user_posts = @user.posts.order('updated_at DESC').paginate(page: params[:page])
    elsif @user.real_name?
      @user_posts = @user.posts.where(publish: true).order('updated_at DESC').paginate(page: params[:page])
    end
    if current_user
      @channels = Channel.with_role(:manager, current_user)
    end
    unless @user_posts
      flash[:alert] = "No posts published by that user."
      redirect_to feed_path
    end
  end

end
