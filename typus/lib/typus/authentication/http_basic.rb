module Typus
  module Authentication
    module HttpBasic

      protected

      include Base

      def authenticate
        @admin_user = FakeUser.new
        authenticate_or_request_with_http_basic(Typus.admin_title) do |username, password|
          username == Typus.username && password == Typus.password
        end
      end

    end
  end
end
