class Site < ActiveRecord::Base

  ##
  # Validations
  #

  validates :domain, :presence => true
  validates :name, :presence => true

  ##
  # Associations
  #

  has_many :views

end
