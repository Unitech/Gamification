module Admin::Resources::RelationshipsHelper

  def setup_relationship(field)
    @field = field
    @model_to_relate = @resource.reflect_on_association(field.to_sym).class_name.constantize
    @model_to_relate_as_resource = @model_to_relate.to_resource
    @reflection = @resource.reflect_on_association(field.to_sym)
    @association_name = @reflection.name.to_s
  end

  def build_pagination
    items_per_page = @model_to_relate.typus_options_for(:per_page)
    data = @item.send(@field).order(@model_to_relate.typus_order_by).where(set_conditions)
    page = params["#{@association_name}_page"]
    @items = data.page(page).per(items_per_page)
  end

  def build_relationship_table
    build_list(@model_to_relate,
               @model_to_relate.typus_fields_for(:relationship),
               @items,
               @model_to_relate_as_resource,
               {},
               @reflection.macro,
               @association_name)
  end

  def set_conditions
    if @model_to_relate.typus_options_for(:only_user_items) && admin_user.is_not_root?
      { Typus.user_foreign_key => admin_user }
    end
  end

end
