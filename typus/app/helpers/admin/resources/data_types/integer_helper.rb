module Admin::Resources::DataTypes::IntegerHelper

  def integer_filter(filter)
    values = set_context.send(filter.to_s.pluralize).to_a
    items = [[Typus::I18n.t("Show by %{attribute}", :attribute => @resource.human_attribute_name(filter).downcase), ""]]
    array = values.first.is_a?(Array) ? values : values.map { |i| [i, i] }
    items += array
  end

end
