class ReferenceData

  def self.reference value
    constants.detect {|const_name| const_get(const_name) == value }
  end

  def self.ordered_constants
    constants.sort {|c1, c2| const_get(c1) <=> const_get(c2) }
  end

  def self.name_from_value value
    attribute = name.split('::').last.underscore
    enclosing_class = name.split('::').first.underscore
    i18n_prefix = "activerecord.attributes_data.#{enclosing_class}.#{attribute}"
    I18n.t("#{i18n_prefix}_#{value}")
  end

  def self.find_name const_name
    name_from_value(const_get(const_name))
  end

  def self.ordered_values
    ordered_constants.map {|const_name| [find_name(const_name), const_get(const_name)]}
  end

  def self.options opts={}


    result = ordered_values
    result.reject! {|option| !opts[:only].include? option.last } if opts.include? :only
    result.unshift [opts[:blank], ''] if opts.include? :blank
    result
  end

end
