class EntrMissionUser < ActiveRecord::Base
  belongs_to :mission #, :order_by => 'begin_date ASC'
  belongs_to :user

  STATES = [['New', 0], ['Confirmed', 1], ['Finished', 2]]

  def self.states
    STATES
  end
  
end
