module Typus
  module Authentication
    module Devise

      protected

      include Base

      def admin_user
        send("current_#{Typus.user_class_name.underscore}")
      end

      def authenticate
        send("authenticate_#{Typus.user_class_name.underscore}!")
      end

    end
  end
end