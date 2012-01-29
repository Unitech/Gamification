class Order < ActiveRecord::Base

  ##
  # Associations
  #

  has_one :invoice

  ##
  # Instance Methods
  #

  def to_label
    number
  end

end
