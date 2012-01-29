class Comment < ActiveRecord::Base

  ##
  # Validations
  #

  validates :email, :presence => true
  validates :body, :presence => true
  validates :name, :presence => true

  ##
  # Associations
  #

  belongs_to :post

  ##
  # Instance Methods
  #

  def to_label
    name
  end

end
