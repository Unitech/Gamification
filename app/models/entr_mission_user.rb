class EntrMissionUser < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user

  STATES = [['New', 0], ['Confirmed', 1], ['Finished', 2]]
end
