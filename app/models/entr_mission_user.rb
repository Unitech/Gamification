class EntrMissionUser < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  
  # Only one relationship can be made
  validates_uniqueness_of :user_id, :scope => :mission_id

  class Status < ReferenceData
    APPLIED = 0
    CONFIRMED = 1
    DONE = 2
    CANCELED = 3
  end

  STATES = [['<span style="color : OrangeRed ">Applied</span>'.html_safe, 0], 
            ['<span style="color : green">Confirmed</span>'.html_safe, 1], 
            ['<span style="color : blue">Finished</span>'.html_safe, 2],
            ['<span style="color : red">Canceled</span>'.html_safe, 3]]

  def self.states
    STATES
  end

  def self.actions_total_on date
    where("date(updated_at) = ?", date).count
  end

  def contextualize_state    
    STATES[self.state][0]
  end

  scope :get_from_user_and_missions_id, lambda { |mission, user|
    where("mission_id = ? AND user_id = ?", 
          mission,
          user).first
  }

end
