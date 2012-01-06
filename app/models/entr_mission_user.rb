class EntrMissionUser < ActiveRecord::Base
  belongs_to :mission #, :order_by => 'begin_date ASC'
  belongs_to :user

  class Status < ReferenceData
    APPLIED = 0
    CONFIRMED = 1
    DONE = 2
    CANCELED = 3
  end

  STATES = [['Applied', 0], 
            ['Confirmed', 1], 
            ['Finished', 2],
            ['Canceled', 3]]

  def self.states
    STATES
  end

  scope :get_from_user_and_missions_id, lambda { |mission, user|
    where("mission_id = ? AND user_id = ?", 
          mission,
          user).first
  }

end
