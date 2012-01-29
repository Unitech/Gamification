module Typus
  module Authentication
    module Session

      protected

      include Base

      def authenticate
        unless session[:typus_user_id] && admin_user && admin_user.active?
          deauthenticate
        end
      end

      def deauthenticate
        session[:typus_user_id] = nil
        redirect_to new_admin_session_path
      end

      #--
      # Return the current user. If role does not longer exist on the system
      # admin_user will be signed out from the system.
      #++
      def admin_user
        @admin_user ||= Typus.user_class.find_by_id(session[:typus_user_id])
      end

      #--
      # This method checks if the user can perform the requested action.
      # It works on models, so its available on the `resources_controller`.
      #++
      def check_if_user_can_perform_action_on_resources
        if @item && @item.is_a?(Typus.user_class)
          check_if_user_can_perform_action_on_user
        else
          not_allowed if admin_user.cannot?(params[:action], @resource.model_name)
        end
      end

      #--
      # Action is available on: edit, update, toggle and destroy
      #++
      def check_if_user_can_perform_action_on_user
        is_current_user = (admin_user == @item)
        current_user_is_root = admin_user.is_root? && is_current_user

        case params[:action]
        when 'edit'
          # Edit other items is not allowed unless current user is root
          # and is not the current user.
          not_allowed if admin_user.is_not_root? && !is_current_user
        when 'toggle', 'destroy'
          not_allowed if admin_user.is_not_root? || current_user_is_root
        when 'update'
          # Admin can update himself except setting the status to false!. Other
          # users can update their profile as the attributes (role & status)
          # are protected.
          status_as_boolean = params[@object_name][:status] == "1" ? true : false

          status_changed = !(@item.status == status_as_boolean)
          role_changed = !(@item.role == params[@object_name][:role])

          root_changed_his_status_or_role = current_user_is_root && (status_changed || role_changed)
          not_root_tries_to_change_another_user = admin_user.is_not_root? && !is_current_user

          not_allowed if root_changed_his_status_or_role || not_root_tries_to_change_another_user
        end
      end

      #--
      # This method checks if the user can perform the requested action.
      # It works on a resource: git, memcached, syslog ...
      #++
      def check_if_user_can_perform_action_on_resource
        resource = params[:controller].remove_prefix.camelize
        not_allowed if admin_user.cannot?(params[:action], resource, { :special => true })
      end

      #--
      # If item is owned by another user, we only can perform a show action on
      # the item. Updated item is also blocked.
      #++
      def check_resource_ownership
        if admin_user.is_not_root?

          condition_typus_users = @item.respond_to?(Typus.relationship) && !@item.send(Typus.relationship).include?(admin_user)
          condition_typus_user_id = @item.respond_to?(Typus.user_foreign_key) && !admin_user.owns?(@item)

          not_allowed if (condition_typus_users || condition_typus_user_id)
        end
      end

      #--
      # Show only related items it @resource has a foreign_key (Typus.user_foreign_key)
      # related to the logged user.
      #++
      def check_resources_ownership
        if admin_user.is_not_root? && @resource.typus_user_id?
          @resource = @resource.where(Typus.user_foreign_key => admin_user)
        end
      end

      ##
      # OPTIMIZE: This method should accept args.
      #
      def set_attributes_on_create
        @item.send("#{Typus.user_foreign_key}=", admin_user.id) if @resource.typus_user_id?
      end

      ##
      # OPTIMIZE: This method should accept args and not perform an update
      #           because we are updating the attributes twice!
      #
      def set_attributes_on_update
        if @resource.typus_user_id? && admin_user.is_not_root?
          @item.update_attributes(Typus.user_foreign_key => admin_user.id)
        end
      end

    end
  end
end
