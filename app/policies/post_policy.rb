class PostPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @post = model
  end

  def new?
    user_signed_in?
  end

  def create?
    user_signed_in?
  end

  def show?
    if @current_user
      (@post.publish and @post.user.real_name) or (@post.user == @current_user) or @current_user.is_admin?
    else
      @post.publish and @post.user.real_name
    end
  end

  def edit?
    @post.user == @current_user
  end

  def edit_html?
    @post.user == @current_user
  end

  def update?
    @post.user == @current_user
  end

  def destroy?
    @post.user == @current_user
  end

  def feed?
    true
  end

end
