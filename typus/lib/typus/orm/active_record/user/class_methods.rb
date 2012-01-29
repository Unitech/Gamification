module Typus
  module Orm
    module ActiveRecord
      module User
        module ClassMethods

          def generate(*args)
            options = args.extract_options!
            options[:password] ||= Typus.password
            options[:role] ||= Typus.master_role
            options[:status] = true
            user = new options, :without_protection => true
            user.save ? user : false
          end

          def roles
            Typus::Configuration.roles.keys.sort
          end

          def locales
            Typus::I18n.available_locales
          end

        end
      end
    end
  end
end
