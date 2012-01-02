class Mission < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "50x50>" }

  has_many :comments
  
  has_many :entr_mission_users
  has_many :users, :through => :entr_mission_users
  
  def to_param
    self.id.to_s + '-' + self.title.parameterize
  end
end
