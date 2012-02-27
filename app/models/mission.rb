# -*- coding: utf-8 -*-
class Mission < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "50x50#", :big => "500x500>" }

  default_scope :order => 'missions.updated_at ASC'
  
  has_many :comments
  
  has_many :entr_mission_users
  has_many :users, :through => :entr_mission_users

  class Status < ReferenceData
    NEW = 0
    CONFIRMED = 1
    FINISHED = 2
  end

  CATEGORY = [['Mission', 0], 
              ['Meeting', 1], 
              ['Cours', 2], 
              ['Soutenance', 3], 
              ['Autre', 4]]

  STATES = [['New', 0], 
            ['Confirmed', 1], 
            ['Finished', 2]]

  #
  # Validators
  #
  validates_presence_of :title
  validates_presence_of :resume
  validates_presence_of :description
  
  #
  # Typus
  #
  def self.categories
    CATEGORY
  end
  
  def self.states
    STATES
  end

  def duration
    (end_date - begin_date) / 1.day
  end
  
  def user_interested
    EntrMissionUser.where('mission_id = ?', self.id).count
  end

  def to_label
    "#{self.title}"
  end

  def is_in_process?
    if self.state == Mission::Status::CONFIRMED
      return true
    else
      return false
    end
  end

  def attach_new_user user
    link = EntrMissionUser.new(:user => user,
                               :mission_id => self.id,
                               :state => EntrMissionUser::STATES[0][1])
    if link.save
      true
    else
      false
    end
  end

  def reward_description
    string = "<div id='reward_description'>"

    if self.euros > 0 
      string += "#{self.euros} euros<br/>"
    end
    if self.epices > 0 
      string += "#{self.epices} epices<br/>"
    end
    if self.points > 0 
      string += "#{self.points} points<br/>"
    end
    
    string += '</div>'
    string.html_safe
  end
  
  # Typus default
  def initialize_with_defaults(attributes = nil, &block)
    initialize_without_defaults(attributes) do
      self.begin_date = Date.today
      self.end_date = Date.today
      self.euros = 0
      self.epices = 0
      self.points = 0
      self.state = 0
      yield self if block_given?
    end
  end

  alias_method_chain :initialize, :defaults

  def to_param
    self.id.to_s + '-' + self.title.parameterize
  end

  def to_label
    "#{self.title}"
  end

  alias :to_s :to_label

  ####################
  #
  # Some Scopes
  #
  ####################

  # Missions that have already people who applied to it
  scope :pending_missions,
        includes(:entr_mission_users)
    .where('entr_mission_users.state = ?', EntrMissionUser::Status::APPLIED)
  
  scope :processing_missions,
        where('missions.state = ?', Mission::Status::CONFIRMED)
  
  scope :finished_missions,
        where('missions.state = ?', Mission::Status::FINISHED)


  # Select all pending missions of the user that are not alredy confirmed
  scope :user_todo_missions, lambda { |user|
    EntrMissionUser
      .includes(:mission, {:mission => :comments})
      .where("entr_mission_users.user_id = ? AND entr_mission_users.state = ?", user.id, EntrMissionUser::Status::CONFIRMED)
      .collect { |l| l.mission }
  }

  scope :user_pending_missions, lambda { |user|
    EntrMissionUser
      .includes(:mission, {:mission => :comments})
      .where("entr_mission_users.user_id = ? AND entr_mission_users.state = ?", user.id, EntrMissionUser::Status::APPLIED)
      .collect { |l| l.mission }
  }  

  scope :user_canceled_missions, lambda { |user|
    EntrMissionUser
      .includes(:mission, {:mission => :comments})
      .where("entr_mission_users.user_id = ? AND entr_mission_users.state = ?", user.id, EntrMissionUser::Status::CANCELED)
      .collect { |l| l.mission }
  }
  
  scope :user_finished_missions, lambda { |user|
    EntrMissionUser
      .includes(:mission, {:mission => :comments})
      .where("entr_mission_users.user_id = ? AND entr_mission_users.state = ?", user.id, EntrMissionUser::Status::DONE)
      .collect { |l| l.mission }
  }

  #
  # Global method to get all users linked to mission
  #
  def user_doing_missions
    EntrMissionUser
      .includes(:user)
      .where("entr_mission_users.mission_id = ? AND entr_mission_users.state = ?", self.id, EntrMissionUser::Status::CONFIRMED)
      .collect { |l| l.user }
  end

  # user eject because we dont send a mail to the comment writter
  def user_want_notified_new_comment user_eject
    EntrMissionUser
      .includes(:user)
      .where("entr_mission_users.mission_id = ? AND users.mail_comments = ? AND users.id != ?", 
             self.id, 
             true, 
             user_eject.id)
      .collect { |l| l.user }
  end

  # user eject because we dont send a mail to the comment writter
  # when mission is validated only send to confirmed users
  def user_want_notified_new_comment_advanced user_eject
    EntrMissionUser
      .includes(:user)
      .where("entr_mission_users.mission_id = ? AND users.mail_comments = ? AND users.id != ? AND entr_mission_users.state = ?", 
             self.id, 
             true, 
             user_eject.id, 
             EntrMissionUser::Status::CONFIRMED)
      .collect { |l| l.user }
  end

end
