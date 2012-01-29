require 'typus/orm/active_record/user/instance_methods'
require 'typus/orm/active_record/user/class_methods'

module Typus
  module Orm
    module ActiveRecord
      module AdminUserV1

        module ClassMethods

          def enable_as_typus_user

            extend Typus::Orm::ActiveRecord::User::ClassMethods

            include Typus::Orm::ActiveRecord::User::InstanceMethods
            include InstanceMethods

            attr_accessor :password

            attr_protected :role, :status

            validates :email, :presence => true, :uniqueness => true, :format => { :with => Typus::Regex::Email }

            validates :password,
                      :confirmation => { :if => :password_required? },
                      :presence => { :if => :password_required? }

            validates_length_of :password, :within => 6..40, :if => :password_required?

            validates :role, :presence => true

            before_save :initialize_salt, :encrypt_password, :set_token

            serialize :preferences

            def self.authenticate(email, password)
              user = find_by_email_and_status(email, true)
              user && user.authenticated?(password) ? user : nil
            end

          end

        end

        module InstanceMethods

          def to_label
            full_name = [first_name, last_name].delete_if { |s| s.blank? }
            full_name.any? ? full_name.join(" ") : email
          end

          def locale
            (preferences && preferences[:locale]) ? preferences[:locale] : ::I18n.default_locale
          end

          def locale=(locale)
            self.preferences ||= {}
            self.preferences[:locale] = locale
          end

          def authenticated?(password)
            crypted_password == encrypt(password)
          end

          protected

          def generate_hash(string)
            Digest::SHA1.hexdigest(string)
          end

          def encrypt_password
            return if password.blank?
            self.crypted_password = encrypt(password)
          end

          def encrypt(string)
            generate_hash("--#{salt}--#{string}--")
          end

          def initialize_salt
            self.salt = generate_hash("--#{Time.zone.now.to_s(:number)}--#{email}--") if new_record?
          end

          def password_required?
            crypted_password.blank? || !password.blank?
          end

        end

      end
    end
  end
end
