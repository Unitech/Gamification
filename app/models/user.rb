require 'typus/orm/active_record/user/instance_methods'
require 'typus/orm/active_record/user/instance_methods_more'

class User < ActiveRecord::Base
  before_create :default_values
  after_create :gift_user

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable#, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :f_name, :l_name, :username, :website

  include Typus::Orm::ActiveRecord::User::InstanceMethods
  include Typus::Orm::ActiveRecord::User::InstanceMethodsMore

  has_many :comments
  has_many :entr_mission_users
  has_many :missions, :through => :entr_mission_users
  has_one :user_ressource
  has_many :wallet_operation

  alias :to_s :to_label



  # Typus
  def to_label
    "#{self.f_name} #{self.l_name}"
  end

  def missions_applied
    self.entr_mission_users.where(:state => EntrMissionUser::Status::APPLIED).count
  end

  def missions_todo
    self.entr_mission_users.where(:state => EntrMissionUser::Status::CONFIRMED).count
  end

  def missions_done
    self.entr_mission_users.where(:state => EntrMissionUser::Status::DONE).count
  end

  def missions_refused
    self.entr_mission_users.where(:state => EntrMissionUser::Status::CANCELED).count
  end



  #
  # Attribute override
  #
  def username
    self.to_label
  end

  def credit_user mission
    WalletOperation.credit_user self, mission
  end

  # Some validations
  validates_uniqueness_of :username

  # Some Methods
  def has_link_with_mission mission_id
    entr = EntrMissionUser.where("user_id = ? AND mission_id = ?", self.id, mission_id)
    if entr.empty?
      return false
    end

    return entr.first.state
  end

  def is_admin?
    self.admin || false
  end

  ## OAuth
  def self.find_for_labz_oauth(info, signed_in_ressource=nil)
    # You can also propagate admin rights from labz,
    # ex : user.admin = true if info.groups.include? "root"

    if user = User.where(:email => info.login_mail).first
      user
      # Uncomment to allow automatic merging of account with labz (untested)
      # elsif signed_in_ressource
      #   signed_in_ressource.email = data.login_mail
      #   signed_in_ressource.save
    else # Create a user with a stub password.
      User.create!(:email => info.login_mail, :password => Devise.friendly_token[0,20])
    end
  end

  protected

  def gift_user
    WalletOperation.direct_credit_user self, 10, 10
  end

  def default_values
    self.cash = 0
    self.epices = 0
    self.points = 0
  end
end
