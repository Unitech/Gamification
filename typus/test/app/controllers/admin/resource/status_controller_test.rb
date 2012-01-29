require "test_helper"

=begin

  What's being tested here?

    - Resource controller.

=end

class Admin::StatusControllerTest < ActionController::TestCase

  test "index works when user has access" do
    admin_sign_in
    get :index
    assert_response :success
    assert_template 'index'
  end

  test "index returns unprocessable_entity when user has no access" do
    editor_sign_in
    get :index
    assert_response :unprocessable_entity
  end

  test "index redirects to new_admin_session_path when user is not logged" do
    reset_session
    get :index
    assert_response :redirect
    assert_redirected_to new_admin_session_path
  end

end
