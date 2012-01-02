class Mission < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "50x50#", :big => "500x500>" }

  has_many :comments
  
  has_many :entr_mission_users
  has_many :users, :through => :entr_mission_users
  

  
  scope :waiting_missions, lambda {|user|
      order('begin_date ASC')
      .where('id in (?)', user.missions.map(&:id))
  }
  
  scope :todo_missions, lambda {|user|
    order('begin_date ASC')
      .where('id in (?)', user.missions.map(&:id))
  }
  
  def to_param
    self.id.to_s + '-' + self.title.parameterize
  end

end
