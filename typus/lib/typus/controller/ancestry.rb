module Typus
  module Controller
    module Ancestry

      def index
        items = []

        @resource.roots.each do |item|
          items << item
          if item.has_children?
            item.children.each do |child|
              items << child
              if child.has_children?
                child.children.each do |child|
                  items << child
                end
              end
            end
          end
        end

        @items = Kaminari.paginate_array(items).page(params[:page]).per(1000)

        set_default_action
        add_resource_action("Trash", {:action => "destroy"}, {:confirm => "#{Typus::I18n.t("Trash")}?", :method => 'delete'})
      end

    end
  end
end
