module Admin::Resources::DataTypes::SelectorHelper

  def table_selector_field(attribute, item)
    item.mapping(attribute)
  end

  def display_selector(item, attribute)
    item.mapping(attribute)
  end

end
