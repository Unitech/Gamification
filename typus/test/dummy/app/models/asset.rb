=begin

  This model is used to test:

    - Dragonfly Attachments
    - Paperclip Attachments

=end

class Asset < ActiveRecord::Base

  ##
  # Dragonfly Stuff
  #

  if defined?(Dragonfly)

    image_accessor :dragonfly

    image_accessor :dragonfly_required
    validates :dragonfly_required, :presence => true

  end

  ##
  # Paperclip Stuff
  #

  if defined?(Paperclip)

    has_attached_file :paperclip, :styles => { :medium => "300x300>", :thumb => "100x100>" }

    has_attached_file :paperclip_required, :styles => { :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment_presence :paperclip_required

  end

  ##
  # Instance Methods
  #

  def original_file_name
  end

end
