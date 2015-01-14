class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:feed, :show]  # Duplicated in post_policy.
  after_action :verify_authorized

  def new
    @post = current_user.posts.build
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post
    if params[:commit] == 'Cancel unsaved changes'
      flash[:notice] = "Unsaved changes cancelled."
      redirect_to current_user and return
    elsif @post.save
      update_response(@post, params); return if performed?
    else
      flash[:alert] = "Sorry, couldn't create post. Try again?"
      render 'posts/new'
    end
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
    if current_user
      @channels = Channel.with_role(:manager, current_user)
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def edit_html
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if params[:commit] == 'Cancel unsaved changes'
      flash[:notice] = "Unsaved changes cancelled."
      redirect_to @post and return
    elsif @post.update_attributes(post_params)
      update_response(@post, params); return if performed?
    else
      flash[:alert] = "Sorry, couldn't update post. Try again?"
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    authorize @post
    flash[:notice] = "Post deleted."
    redirect_to current_user || root_url
  end

  def feed
    @feed_posts = Post.joins(:user).where(users: {real_name: true}).where(posts: {publish: true}).order('updated_at DESC').paginate(page: params[:page])
    authorize @feed_posts
    if current_user
      @channels = Channel.with_role(:manager, current_user)
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :publish, :bootsy_image_gallery_id, :custom)
    end

    def update_response(post, params)
      if params[:commit] == 'Save & edit more'
        flash[:notice] = "Post saved."
        redirect_to edit_post_path(post) and return
      elsif params[:commit] == 'Convert this post to html editing'
        post.custom = true
        post.save
        flash[:notice] = "Post converted."
        redirect_to edit_post_path(post) and return
      elsif params[:commit] == 'Dump custom html editing'
        post.custom = false
        post.save
        flash[:alert] = "Custom html dumped."
        redirect_to edit_post_path(post) and return
      else  # Should be the only other case: params[:commit] == 'Save & view post'
        flash[:notice] = "Post saved."
        redirect_to post and return
      end
    end
end
