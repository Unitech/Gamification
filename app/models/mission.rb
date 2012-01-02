class Mission < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "50x50#", :big => "500x500>" }

  has_many :comments
  
  has_many :entr_mission_users
  has_many :users, :through => :entr_mission_users

  CATEGORY = [['Mission', 0], ['Meeting', 1], ['Cours', 2], ['Soutenance', 3], ['Autre', 4]]
  STATES = [['New', 0], ['Taken', 1], ['Confirmed', 2], ['Finished', 3]]

  # Typus
  def self.categories
    CATEGORY
  end
  def self.states
    STATES
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
  
  scope :user_pending_missions, lambda { |user|
      order('begin_date ASC')
      .where('id in (?) AND state = ?', user.missions.map(&:id), EntrMissionUser::STATES[0][1])
  }

  scope :pending_missions, where('state = ?', EntrMissionUser::STATES[0][1])
  
  scope :user_todo_missions, lambda { |user|
    order('begin_date ASC')
      .where('id in (?) AND state = ?', user.missions.map(&:id), EntrMissionUser::STATES[1][1])
  }

  scope :user_finished_missions, lambda { |user|
      order('begin_date ASC')
      .where('id in (?) AND state = ?', user.missions.map(&:id), EntrMissionUser::STATES[2][1])
  }
  
  def to_param
    self.id.to_s + '-' + self.title.parameterize
  end

end
