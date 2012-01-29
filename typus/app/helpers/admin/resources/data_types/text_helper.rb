module Admin::Resources::DataTypes::TextHelper

  def table_text_field(attribute, item)
    (raw_content = item.send(attribute)).present? ? truncate(raw_content) : mdash
  end

end
