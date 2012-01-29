class String

  def extract_settings
    split(",").map(&:strip)
  end

  def remove_prefix
    split("/")[1..-1].join("/")
  end

  def extract_class
    remove_prefix.classify.constantize
  end

  ##
  # CRUD: create, read, update, delete
  #
  # You can read more at http://en.wikipedia.org/wiki/Create,_read,_update_and_delete
  #
  def acl_action_mapper
    case self
    when "new", "create"
      "create"
    when "index", "show"
      "read"
    when "edit", "update", "position", "toggle", "relate", "unrelate"
      "update"
    when "destroy", "trash"
      "delete"
    else
      self
    end
  end

  def to_resource
    self.underscore.pluralize
  end

end
