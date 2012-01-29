module ApplicationHelper
  def image_url(source)
    "#{root_url}#{image_path(source)}"
  end

  def markdown(text, id = 'markdown')
    if (text == nil)
      return ''
    end
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    dt = Redcarpet.new(text, *options).to_html.html_safe
    content_tag(:div, dt, :id => id)
  end
end
