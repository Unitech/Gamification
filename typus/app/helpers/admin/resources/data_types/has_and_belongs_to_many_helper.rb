module Admin::Resources::DataTypes::HasAndBelongsToManyHelper

  def table_has_and_belongs_to_many_field(attribute, item)
    item.send(attribute).map(&:to_label).join(", ")
  end

  alias_method :table_has_many_field, :table_has_and_belongs_to_many_field

  def typus_has_and_belongs_to_many_field(attribute, form)
    klass = @resource.reflect_on_association(attribute.to_sym).class_name.constantize

    resource_ids = "#{attribute.singularize}_ids"
    html_options = { :disabled => attribute_disabled?(resource_ids.to_sym) }
    model = @resource.name.underscore.gsub("/", "_")
    options = { :attribute => "#{model}_#{attribute}" }

    label_text = @resource.human_attribute_name(attribute)
    if (text = build_label_text_for_has_and_belongs_to_many(klass, html_options, options))
      label_text += "<small>#{text}</small>"
    end

    locals = { :attribute => attribute,
               :attribute_id => "#{model}_#{attribute}",
               :related_klass => klass,
               :related_items => @item.send(attribute),
               :related_ids => "#{model}[#{resource_ids}][]",
               :values => klass,
               :form => form,
               :label_text => label_text.html_safe,
               :html_options => html_options }

    render "admin/templates/has_and_belongs_to_many", locals
  end

  def build_label_text_for_has_and_belongs_to_many(klass, html_options, options = {})
    if html_options[:disabled] == true
      Typus::I18n.t("Read only")
    elsif admin_user.can?('create', klass) && !headless_mode?
      build_add_new_for_has_and_belongs_to_many(klass, options)
    end
  end

  def build_add_new_for_has_and_belongs_to_many(klass, options)
    options = { :controller => "/admin/#{klass.to_resource}",
                :action => "new",
                :attribute => options[:attribute],
                :_popup => true }

    link_to Typus::I18n.t("Add New"), options, { :class => "iframe" }
  end

end
