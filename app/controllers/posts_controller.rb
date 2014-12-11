class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_action :correct_user,   only: [:update, :destroy]

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

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:notice] = "Post updated!"
    else
      flash[:alert] = "Sorry, couldn't update post. Try again?"
    end
    redirect_to @post
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"
    redirect_to current_user || root_url
  end

  def feed
    @feed_posts = Post.where(publish: true).order('updated_at DESC').paginate(page: params[:page])
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :publish)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
