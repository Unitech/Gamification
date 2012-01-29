module Typus
  module Controller
    module Headless

      def self.included(base)
        base.before_filter :set_resources_action_for_headless_on_index, :only => [:index, :trash]
        base.before_filter :set_resources_action_for_headless, :only => [:new, :create, :edit, :show]
        base.helper_method :headless_mode?
        base.layout :headless_layout
      end

      def set_resources_action_for_headless_on_index
        add_resources_action("Add New", {:action => "new"})
      end
      private :set_resources_action_for_headless_on_index

      def set_resources_action_for_headless
        if params[:_input]
          add_resources_action("All Entries", {:action => 'index', :id => nil})
        end
      end
      private :set_resources_action_for_headless

      def headless_layout
        headless_mode? ? "admin/headless" : "admin/base"
      end
      private :headless_layout

      def headless_mode?
        params[:_popup]
      end

    end
  end
end
