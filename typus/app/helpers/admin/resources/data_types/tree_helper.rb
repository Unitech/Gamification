module Admin::Resources::DataTypes::TreeHelper

  def table_tree_field(attribute, item)
    item.parent ? item.parent.to_label : mdash
  end

  def typus_tree_field(attribute, form)
    locals = { :attribute => attribute,
               :attribute_id => "#{@resource.table_name}_#{attribute}",
               :form => form,
               :label_text => @resource.human_attribute_name(attribute),
               :values => expand_tree_into_select_field(@resource.roots, "parent_id") }

    render "admin/templates/tree", locals
  end

  def expand_tree_into_select_field(items, attribute)
    String.new.tap do |html|
      items.each do |item|
        html << %{<option #{"selected" if @item.send(attribute) == item.id} value="#{item.id}">#{"&nbsp;" * item.ancestors.size * 2} #{item.to_label}</option>\n}
        html << expand_tree_into_select_field(item.children, attribute) unless item.children.empty?
      end
    end
  end

end
