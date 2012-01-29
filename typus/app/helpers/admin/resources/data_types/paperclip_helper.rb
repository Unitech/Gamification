module Admin::Resources::DataTypes::PaperclipHelper

  def table_paperclip_field(attribute, item)
    options = { :width => 25 }
    typus_paperclip_preview(item, attribute, options)
  end

  def link_to_detach_attribute_for_paperclip(attribute)
    validators = @item.class.validators.delete_if { |i| i.class != ActiveModel::Validations::PresenceValidator }.map(&:attributes).flatten.map(&:to_s)
    attachment = @item.send(attribute)

    if attachment.exists? && !validators.include?("#{attribute}_file_name") && attachment
      attribute_i18n = @item.class.human_attribute_name(attribute)
      label_text = <<-HTML
#{attribute_i18n}
<small>#{link_to Typus::I18n.t("Remove"), { :action => 'update', :id => @item.id, :_nullify => attribute, :_continue => true }, :confirm => Typus::I18n.t("Are you sure?")}</small>
      HTML
      label_text.html_safe
    end
  end

  def typus_paperclip_preview(item, attachment, options = {})
    if (data = item.send(attachment)).exists?
      styles = data.styles.keys
      if data.content_type =~ /^image\/.+/ && styles.include?(Typus.file_preview) && styles.include?(Typus.file_thumbnail)
        render "admin/templates/paperclip_preview",
               :preview => data.url(Typus.file_preview, false),
               :thumb => data.url(Typus.file_thumbnail, false),
               :options => options
      else
        link_to data.original_filename, data.url(:original, false)
      end
    end
  end

end
