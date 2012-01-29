module Typus
  module Orm
    module ActiveRecord
      module User
        module InstanceMethods

          def to_label
            email
          end

          def resources
            Typus::Configuration.roles[role.to_s].compact
          end

          def models
            Typus.models.delete_if { |m| cannot?('read', m) }
          end

          def applications
            Typus.applications.delete_if { |a| application(a).empty? }
          end

          def application(name)
            Typus.application(name).delete_if { |r| !resources.keys.include?(r) }
          end

          def can?(action, resource, options = {})
            resource = resource.model_name if resource.is_a?(Class)

            return false if !resources.include?(resource)
            return true if resources[resource].include?("all")

            action = options[:special] ? action : action.acl_action_mapper

            resources[resource].extract_settings.include?(action)
          end

          def cannot?(*args)
            !can?(*args)
          end

          def is_root?
            role == Typus.master_role
          end

          def is_not_root?
            !is_root?
          end

          def active?
            status && Typus::Configuration.roles.has_key?(role)
          end

          def locale
            (preferences && preferences[:locale]) ? preferences[:locale] : ::I18n.default_locale
          end

          def locale=(locale)
            self.preferences ||= {}
            self.preferences[:locale] = locale
          end

          def owns?(resource)
            id == resource.send(Typus.user_foreign_key)
          end

          def set_token
            token = "#{SecureRandom.hex(6)}-#{SecureRandom.hex(6)}"
            token.encode!('UTF-8') if token.respond_to?(:encode)
            self.token = token
          end
          protected :set_token

        end
      end
    end
  end
end
