# -*- encoding: utf-8 -*-

require "test_helper"

class Admin::SidebarHelperTest < ActiveSupport::TestCase

  include Admin::SidebarHelper

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper

  def render(*args); args; end
  def link_to(*args); args; end

  setup do
    default_url_options[:host] = 'test.host'
  end

end
