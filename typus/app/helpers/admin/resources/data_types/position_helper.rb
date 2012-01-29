module Admin::Resources::DataTypes::PositionHelper

  def table_position_field(attribute, item, connector = " / ")
    locals = { :html_position => [], :connector => connector, :item => item }
    positions = { :move_to_top => "Top", :move_higher => "Up", :move_lower => "Down", :move_to_bottom => "Bottom" }

    positions.each do |key, value|
      first_item = item.respond_to?(:first?) && ([:move_higher, :move_to_top].include?(key) && item.first?)
      last_item = item.respond_to?(:last?) &&  ([:move_lower, :move_to_bottom].include?(key) && item.last?)

      unless first_item || last_item
        options = { :controller => "/admin/#{item.class.to_resource}", :action => "position", :id => item.id, :go => key }
        locals[:html_position] << link_to(Typus::I18n.t(value), params.merge(options), { :class => Typus::I18n.t(value).downcase })
      end
    end

    render "admin/templates/position", locals
  end

end
