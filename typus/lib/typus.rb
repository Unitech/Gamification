require "support/active_record"
require "support/hash"
require "support/object"
require "support/string"

require "typus/engine"
require "typus/regex"
require "typus/version"

require "typus/orm/base/class_methods"
require "typus/orm/base/search"
require "typus/orm/active_record"
require "typus/orm/mongoid"

require "kaminari"

autoload :FakeUser, "support/fake_user"

module Typus

  autoload :Configuration, "typus/configuration"
  autoload :I18n, "typus/i18n"
  autoload :Resources, "typus/resources"

  module Controller
    autoload :Actions, "typus/controller/actions"
    autoload :ActsAsList, "typus/controller/acts_as_list"
    autoload :Ancestry, "typus/controller/ancestry"
    autoload :Autocomplete, "typus/controller/autocomplete"
    autoload :Bulk, "typus/controller/bulk"
    autoload :FeaturedImage, "typus/controller/featured_image"
    autoload :Filters, "typus/controller/filters"
    autoload :Format, "typus/controller/format"
    autoload :Headless, "typus/controller/headless"
    autoload :Multisite, "typus/controller/multisite"
    autoload :Trash, "typus/controller/trash"
  end

  module Authentication
    autoload :Base, "typus/authentication/base"
    autoload :Devise, "typus/authentication/devise"
    autoload :None, "typus/authentication/none"
    autoload :NoneWithRole, "typus/authentication/none_with_role"
    autoload :HttpBasic, "typus/authentication/http_basic"
    autoload :Session, "typus/authentication/session"
  end

  mattr_accessor :admin_title
  @@admin_title = "Typus"

  mattr_accessor :admin_sub_title
  @@admin_sub_title = <<-CODE
<a href="http://core.typuscmf.com/">core.typuscmf.com</a>
  CODE

  ##
  # Available Authentication Mechanisms are:
  #
  # - none
  # - basic: Uses http authentication
  # - session
  #
  mattr_accessor :authentication
  @@authentication = :none

  mattr_accessor :config_folder
  @@config_folder = "config/typus"

  mattr_accessor :username
  @@username = "admin"

  mattr_accessor :subdomain
  @@subdomain = nil

  ##
  # Pagination options passed to Kaminari helper.
  #
  #     :previous_label => "&larr; " + Typus::I18n.t("Previous")
  #     :next_label => Typus::I18n.t("Next") + " &rarr;"
  #
  # Note that `Kaminari` only accepts the following configuration options:
  #
  # - default_per_page (25 by default)
  # - window (4 by default)
  # - outer_window (0 by default)
  # - left (0 by default)
  # - right (0 by default)
  #
  mattr_accessor :pagination
  @@pagination = { :window => 0 }

  ##
  # Define a password.
  #
  # Used as default password for http and advanced authentication.
  #
  mattr_accessor :password
  @@password = "columbia"

  ##
  # Configure the e-mail address which will be shown in Admin::Mailer. If not
  # set `forgot_password` feature is disabled.
  #
  mattr_accessor :mailer_sender
  @@mailer_sender = nil

  ##
  # Define `paperclip` attachment styles.
  #

  mattr_accessor :file_preview
  @@file_preview = :medium

  mattr_accessor :file_thumbnail
  @@file_thumbnail = :thumb

  ##
  # Define `dragonfly` attachment styles.
  #

  mattr_accessor :image_preview_size
  @@image_preview_size = 'x650>'

  mattr_accessor :image_thumb_size
  @@image_thumb_size = 'x100'

  mattr_accessor :image_table_thumb_size
  @@image_table_thumb_size = '25x25#'

  ##
  # Defines the default relationship table.
  #
  mattr_accessor :relationship
  @@relationship = "typus_users"

  mattr_accessor :master_role
  @@master_role = "admin"

  mattr_accessor :user_class_name
  @@user_class_name = "AdminUser"

  mattr_accessor :user_foreign_key
  @@user_foreign_key = "admin_user_id"

  mattr_accessor :quick_sidebar
  @@quick_sidebar = false

  class << self

    # Default way to setup typus. Run `rails generate typus` to create a fresh
    # initializer with all configuration values.
    def setup
      yield self
      reload!
    end

    def applications
      hash = {}

      Typus::Configuration.config.map { |i| i.last["application"] }.compact.uniq.each do |app|
        settings = app.extract_settings
        hash[settings.first] = settings.size > 1 ? settings.last : 1000
      end

      hash.sort { |a1, a2| a1[1].to_i <=> a2[1].to_i }.map(&:first)
    end

    # Lists modules of an application.
    def application(name)
      array = []

      Typus::Configuration.config.each do |i|
        settings = i.last["application"]
        array << i.first if settings && settings.extract_settings.first.eql?(name)
      end

      array.compact.uniq
    end

    # Lists models from the configuration file.
    def models
      Typus::Configuration.config.map(&:first).sort
    end

    # Lists resources, which are tableless models. This is done by looking at
    # the roles, which handle the permissions for this kind of data.
    def resources
      if roles = Typus::Configuration.roles
        roles.keys.map do |key|
          Typus::Configuration.roles[key].keys
        end.flatten.sort.uniq.delete_if { |x| models.include?(x) }
      else
        []
      end
    end

    # Lists models under <tt>app/models</tt>.
    def detect_application_models
      model_dir = Rails.root.join("app/models")
      Dir.chdir(model_dir) { Dir["**/*.rb"] }
    end

    def application_models
      detect_application_models.map do |model|
        class_name = model.sub(/\.rb$/,"").camelize
        klass = class_name.split("::").inject(Object) { |klass,part| klass.const_get(part) }
        class_name if is_active_record?(klass) && !is_mongoid?(klass)
      end.compact
    end

    def is_active_record?(klass)
      (defined?(ActiveRecord) && klass < ActiveRecord::Base && !klass.abstract_class?)
    end
    private :is_active_record?

    def is_mongoid?(klass)
      (defined?(Mongoid) && klass < Mongoid::Document)
    end
    private :is_mongoid?

    def user_class
      user_class_name.constantize
    end

    def root
      Rails.root.join(config_folder)
    end

    def model_configuration_files
      app = Typus.root.join("**", "*.yml")
      plugins = Rails.root.join("vendor", "plugins", "*", "config", "typus", "**", "*.yml")
      Dir[app, plugins].reject { |f| f.match(/_roles.yml/) }.sort
    end

    def role_configuration_files
      app = Typus.root.join("**", "*_roles.yml")
      plugins = Rails.root.join("vendor", "plugins", "*", "config", "typus", "**", "*_roles.yml")
      Dir[app, plugins].sort
    end

    def reload!
      Typus::Configuration.roles!
      Typus::Configuration.models!
    end

  end

end
