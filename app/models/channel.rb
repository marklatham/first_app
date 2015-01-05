class Channel < ActiveRecord::Base
  resourcify
  belongs_to :manager, class_name: 'User'
  belongs_to :display, class_name: 'Post'
end
