class ChannelPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @channel = model
  end

  def new?
    @current_user.is_admin?
  end

  def create?
    @current_user.is_admin?
  end

  def admin?
    @current_user.is_admin?
  end

  def edit?
    @current_user.is_admin?
  end

  def update?
    @current_user.is_admin?
  end

  def choose_manager?
    @current_user.is_admin?
  end

  def set_manager?
    @current_user.is_admin?
  end

  def remove_manager?
    @current_user.is_admin?
  end

  def update_display?
    @current_user.is_manager_of?(@channel)
  end

  def unset_display?
    @current_user.is_manager_of?(@channel)
  end

  def destroy?
    @current_user.is_admin?
  end

end
