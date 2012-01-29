module Admin::Resources::DataTypes::DateHelper

  def date_filter(filter)
    values = %w(today last_few_days last_7_days last_30_days)
    items = [[@resource.human_attribute_name(filter).capitalize, ""]]
    items += values.map { |v| [Typus::I18n.t(v.humanize), v] }
  end

  alias_method :datetime_filter, :date_filter
  alias_method :timestamp_filter, :date_filter

end
