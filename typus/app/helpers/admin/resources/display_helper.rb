module Admin::Resources::DisplayHelper

  def mdash
    "&mdash;".html_safe
  end

  def build_display(item, fields)
    fields.map do |attribute, type|
      condition = (type == :boolean) || item.send(attribute).present?
      value = condition ? send("display_#{type}", item, attribute) : mdash
      [@resource.human_attribute_name(attribute), value]
    end
  end

  def typus_relationships
    String.new.tap do |html|
      @resource.typus_defaults_for(:relationships).each do |relationship|
        association = @resource.reflect_on_association(relationship.to_sym)
        macro, klass = association.macro, association.class_name.constantize
        if [:has_many, :has_one].include?(macro) && admin_user.can?('read', klass)
          html << send("typus_form_#{macro}", relationship)
        end
      end
    end.html_safe
  end

end
