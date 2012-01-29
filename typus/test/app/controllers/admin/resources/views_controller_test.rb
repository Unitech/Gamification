require "test_helper"

=begin

  What's being tested here?

    - `set_context` which forces the display of items related to domain.

=end

class Admin::ViewsControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
    @site = FactoryGirl.create(:site, :domain => 'test.host')
    FactoryGirl.create(:view, :site => @site)
    FactoryGirl.create(:view)
  end

  test "get index returns only views on the current_context" do
    get :index
    assert_response :success
    assert_equal @site.views, assigns(:items)
  end

  test "get new initializes item in the current_scope" do
    get :new
    assert_response :success
    assert assigns(:item).site.eql?(@site)
  end

end
