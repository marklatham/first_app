class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.is_admin?
  end

  def show?
    @current_user.is_admin? or @current_user == @user
  end

end
