module Admin::Resources::DataTypes::TransversalHelper

  def table_transversal_field(attribute, item)
    field_1, field_2 = attribute.split(".")
    (related_item = item.send(field_1)) ? related_item.send(field_2) : mdash
  end

end
