module ApplicationHelper
  def image_url(source)
    "#{root_url}#{image_path(source)}"
  end
end
