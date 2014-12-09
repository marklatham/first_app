class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_action :correct_user,   only: :destroy

#  after_action :verify_authorized

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to current_user
    else
      flash[:alert] = "Sorry, couldn't create post. Try again?"
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
