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
    @user_posts = @user.posts.paginate(page: params[:page])
    if current_user
      @channels = current_user.channels
    end
  end

end
