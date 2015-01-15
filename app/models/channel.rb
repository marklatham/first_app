class Channel < ActiveRecord::Base
  resourcify
  belongs_to :display, class_name: 'Post'
  has_many :votes
end
