class User < ActiveRecord::Base

  ##
  # Modules
  #

  include Typus::Orm::ActiveRecord::User::InstanceMethods

  ##
  # Associations
  #

  has_many :projects, :dependent => :destroy
  has_many :third_party_projects, :through => :project_collaborators, :dependent => :destroy

end
