class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  # Other devise modules available are :timeoutable and :omniauthable.

  has_many :posts
  has_many :channels, foreign_key: 'manager_id'

  def name
    [first_name, last_name].compact.join(' ')
  end

end
