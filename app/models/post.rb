class Post < ActiveRecord::Base
  include Bootsy::Container
  belongs_to :user
  has_many :channels, foreign_key: 'display_id'
  default_scope -> { order(updated_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end
