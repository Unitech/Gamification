module Typus
  module Orm
    module ActiveRecord
      module User
        module InstanceMethodsMore

          def locale
            ::I18n.locale
          end

          def role
            Typus.master_role
          end

        end
      end
    end
  end
end
