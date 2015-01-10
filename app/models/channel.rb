class Channel < ActiveRecord::Base
  resourcify
  belongs_to :display, class_name: 'Post'
end
