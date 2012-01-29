module Typus
  module Authentication
    module NoneWithRole

      protected

      include Base

      def authenticate
        @admin_user = MyFakeUser.new
      end

    end
  end
end
