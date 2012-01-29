class Task < ActiveRecord::Base

  ##
  # Validations
  #

  validates :name, :presence => true
  validates :project_id, :presence => true
  validates :status, :presence => true

  ##
  # Associations
  #

  belongs_to :project

end
