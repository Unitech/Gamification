module Color
  include ActionView::Helpers::TagHelper

  def self.string tstring, color
    content_tag(:span, tstring)
  end
end
