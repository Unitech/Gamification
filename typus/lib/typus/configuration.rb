require 'erb'

module Typus
  module Configuration

    # Read configuration from <tt>config/typus/*.yml</tt>.
    def self.models!
      @@config = {}

      Typus.model_configuration_files.each do |file|
        if data = YAML::load(ERB.new(File.read(file)).result)
          @@config.merge!(data)
        end
      end
    end

    mattr_accessor :config
    @@config = {}

    # Read roles from files <tt>config/typus/*_roles.yml</tt>.
    def self.roles!
      @@roles = Hash.new({})

      Typus.role_configuration_files.each do |file|
        if data = YAML::load(ERB.new(File.read(file)).result)
          data.compact.each do |key, value|
            @@roles[key] = @@roles[key].merge(value)
          end
        end
      end
    end

    mattr_accessor :roles
    @@roles = Hash.new({})

  end
end
