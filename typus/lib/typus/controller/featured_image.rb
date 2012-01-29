module Typus
  module Controller
    module FeaturedImage

      def set_featured_image
        attachment = Attachment.find(params[:id])

        item = params[:resource].constantize.unscoped.find(params[:resource_id])
        item.set_featured_image(attachment.id)

        options = { :controller => params[:resource].tableize, :action => 'edit', :id => item.id }
        redirect_to options, :notice => Typus::I18n.t("Featured image set")
      end

      def remove_featured_image
        item = @resource.unscoped.find(params[:id])
        item.try(:remove_featured_image)
        options = { :action => 'edit', :id => item.id }
        redirect_to options, :notice => Typus::I18n.t("Featured image removed")
      end

    end
  end
end
