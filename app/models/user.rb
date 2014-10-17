class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    [first_name, last_name].compact.join(' ')
  end
  
  def admin?
    self.has_role? :admin
  end

end
