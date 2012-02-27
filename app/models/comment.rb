class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission

  default_scope :order => 'comments.updated_at DESC'
end
