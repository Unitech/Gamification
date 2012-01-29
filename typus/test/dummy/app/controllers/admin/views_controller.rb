class Admin::ViewsController < Admin::ResourcesController

  def set_context
    @resource = Site.find_by_domain(request.host).send(@object_name.pluralize)
  end
  private :set_context

end
