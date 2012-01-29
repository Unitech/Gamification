module Typus
  module Controller
    module Bulk

      def self.included(base)
        base.helper_method :bulk_actions
        base.before_filter :set_bulk_action, :only => [:index]
        base.before_filter :set_bulk_action_for_trash, :only => [:trash]
      end

      def set_bulk_action
        add_bulk_action("Move to Trash", "bulk_destroy")
      end
      private :set_bulk_action

      # This only happens if we try to access the trash, which won't happen
      # if trash module is not loaded.
      def set_bulk_action_for_trash
        add_bulk_action("Restore from Trash", "bulk_restore")
      end
      private :set_bulk_action_for_trash

      def bulk
        if (ids = params[:selected_item_ids]) && (action = params[:batch_action]).present?
          send(params[:batch_action], ids)
        else
          notice = if action.empty?
            Typus::I18n.t("No bulk action selected.")
          else
            Typus::I18n.t("Items must be selected in order to perform actions on them. No items have been changed.")
          end
          redirect_to :back, :notice => notice
        end
      end

      def bulk_destroy(ids)
        ids.each { |id| @resource.destroy(id) }
        notice = Typus::I18n.t("Successfully deleted #{ids.count} entries.")
        redirect_to :back, :notice => notice
      end
      private :bulk_destroy

      def bulk_restore(ids)
        ids.each { |id| @resource.deleted.find(id).restore }
        notice = Typus::I18n.t("Successfully restored #{ids.count} entries.")
        redirect_to :back, :notice => notice
      end
      private :bulk_restore

      def add_bulk_action(*args)
        bulk_actions
        @bulk_actions << args unless args.empty?
      end
      protected :add_bulk_action

      def prepend_bulk_action(*args)
        bulk_actions
        @bulk_actions = @bulk_actions.unshift(args) unless args.empty?
      end
      protected :prepend_bulk_action

      def append_bulk_action(*args)
        bulk_actions
        @bulk_actions = @bulk_actions.concat([args]) unless args.empty?
      end
      protected :append_bulk_action

      def bulk_actions
        @bulk_actions ||= []
      end

    end
  end
end
