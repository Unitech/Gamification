module Admin::Resources::ListHelper

  def list_actions
    resources_actions_for_current_role.map do |body, url, options|
      path = params.dup.merge!(url).compact.cleanup
      link_to Typus::I18n.t(body), path, options
    end.compact.join(" / ").html_safe
  end

  def resources_actions_for_current_role
    resources_actions.reject do |body, url, options|
      admin_user.cannot?(url[:action], @resource.name)
    end
  end

  def build_actions(&block)
    render "helpers/admin/resources/actions", :block => block
  end

  #--
  # If partial `list` exists we will use it. This partial will have available
  # the `@items` so we can do whatever we want there. Notice that pagination
  # is still available.
  #++
  def build_list(model, fields, items, resource = @resource.to_resource, link_options = {}, association = nil, association_name = nil)
    render "admin/#{resource}/list", :items => items
  rescue ActionView::MissingTemplate
    build_table(model, fields, items, link_options, association, association_name)
  end

  def scopes
    @resource.typus_defaults_for(:scopes).reject { |s| !@resource.respond_to?(s) }
  end

end
