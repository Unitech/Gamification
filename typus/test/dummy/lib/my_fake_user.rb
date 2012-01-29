class MyFakeUser < FakeUser

  def resources
    Typus::Configuration.roles[role.to_s].compact
  end

  def can?(action, resource, options = {})
    resource = resource.model_name if resource.is_a?(Class)

    return false if !resources.include?(resource)
    return true if resources[resource].include?("all")

    action = options[:special] ? action : action.acl_action_mapper

    resources[resource].extract_settings.include?(action)
  end

end