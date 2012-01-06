# -*- coding: utf-8 -*-
class Mission < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "50x50#", :big => "500x500>" }

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
  

  # Validators
  # validates_inclusion_of :category, :in => CATEGORY
  # validates_inclusion_of :state, :in => STATES
  validates_presence_of :title
  validates_presence_of :resume
  validates_presence_of :description
  
  
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
  
  # Missions that have already people who applied to it
  scope :pending_missions,
        includes(:entr_mission_users)
    .where('entr_mission_users.state = ?', EntrMissionUser::Status::APPLIED)

  scope :processing_missions,
        where('missions.state = ?', Mission::Status::CONFIRMED)

  scope :finished_missions,
        where('missions.state = ?', Mission::Status::FINISHED)


  # Select all pending missions of the user that are not alredy confirmed
  scope :user_pending_missions, lambda { |user|
    order('begin_date ASC')
      .where('missions.id in (?) AND state = ?', 
             user.missions.map(&:id), 
             Mission::STATES[0][1])
  }  
  
  scope :user_todo_missions, lambda { |user|
    includes(:entr_mission_users)
      .order('begin_date ASC')
      .where('missions.id in (?) AND entr_mission_users.state = ?', user.missions.map(&:id), EntrMissionUser::STATES[1][1])
  }

  scope :user_finished_missions, lambda { |user|
    includes(:entr_mission_users)
      .order('begin_date ASC')
      .where('id in (?) AND state = ?', user.missions.map(&:id), Mission::STATES[2][1])
  }
  
  def to_param
    self.id.to_s + '-' + self.title.parameterize
  end

  def to_label
    "#{self.title}"
  end

  alias :to_s :to_label

end
