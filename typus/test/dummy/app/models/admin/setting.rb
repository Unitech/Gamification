class Admin::Setting < ActiveRecord::Base

  ##
  # Validations
  #

  validates :key, :presence => true, :uniqueness => true

  ##
  # Class Methods
  #

  def self.table_name_prefix
    'admin_'
  end

  def self.admin_title
    setting = where(:key => "admin_title").first
    if setting && setting.value.present?
      setting.value
    end
  end

end
