class PostsController < ApplicationController
  before_filter :authenticate_user!
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
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end
  
end
