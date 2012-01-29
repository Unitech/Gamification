module Typus
  module Controller
    module Multisite

      def set_context
        @resource = admin_user.site.send(@object_name.pluralize)
      end
      private :set_context

    end
  end
end
