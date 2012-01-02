class User < ActiveRecord::Base
  before_create :default_values

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :f_name, :l_name, :username, :website
  
  has_many :comments

  has_many :entr_mission_users
  has_many :missions, :through => :entr_mission_users

  has_one :user_ressource

  def has_link_with_mission mission_id
    entr = EntrMissionUser.where("user_id = ? AND mission_id = ?", self.id, mission_id)
    if entr.empty?
      return false
    end
    return true
  end

  protected
  
  def default_values
    self.cash = 0
    self.epices = 0
    self.points = 20
  end
end
