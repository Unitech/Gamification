require "test_helper"

class Admin::DashboardControllerTest < ActionController::TestCase

  context "When authentication is http_basic" do

    setup do
      Admin::DashboardController.send :include, Typus::Authentication::HttpBasic
    end

    should "return a 401 message when no credentials sent" do
      get :index
      assert_response :unauthorized
    end

    should "authenticate user with valid password" do
      @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("admin:columbia")
      get :index
      assert_response :success
    end

    should "not authenticate user with invalid password" do
      @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64("admin:admin")
      get :index
      assert_response :unauthorized
    end

  end

  context "When authentication is none" do

    setup do
      Admin::DashboardController.send :include, Typus::Authentication::None
    end

    should "render dashboard" do
      get :index
      assert_response :success
    end

  end

  context "Not logged" do

    setup do
      reset_session
    end

    should "redirect to sign in when not signed in" do
      get :index
      assert_response :redirect
      assert_redirected_to new_admin_session_path
    end

  end

  should "verify_a_removed_role_cannot_sign_in" do
    typus_user = FactoryGirl.create(:typus_user, :role => "removed")
    @request.session[:typus_user_id] = typus_user.id

    get :index

    assert_response :redirect
    assert_redirected_to new_admin_session_path
    assert_nil @request.session[:typus_user_id]
  end

  context "Admin is logged and gets dashboard" do

    setup do
      admin_sign_in
      get :index
    end

    should "render dashboard" do
      assert_response :success
      assert_template "index"
    end

    should "render admin layout" do
      assert_template "layouts/admin/base"
    end

    should "verify title" do
      assert_select "title", "Typus &mdash; Dashboard"
    end

    should "verify link to session sign out" do
      link = %(href="/admin/session")
      assert_match link, response.body
    end

    should "verify link to edit user" do
      link = %(href="/admin/typus_users/edit/#{@request.session[:typus_user_id]})
      assert_match link, response.body
    end

    should "verify we can set our own partials" do
      partials = %w( _sidebar.html.erb )
      partials.each { |p| assert_match p, response.body }
    end

  end

  context "Security" do

    setup do
      admin_sign_in
    end

    should "block users_on_the_fly" do
      @typus_user.status = false
      @typus_user.save

      get :index

      assert_response :redirect
      assert_redirected_to new_admin_session_path
      assert_nil @request.session[:typus_user_id]
    end

    should "sign out user when role does not longer exist" do
      @typus_user.role = 'unexisting'
      @typus_user.save

      get :index

      assert_response :redirect
      assert_redirected_to new_admin_session_path
      assert_nil @request.session[:typus_user_id]
    end

  end

  test "designer should not see links to unallowed resources" do
    designer_sign_in
    get :index
    assert_no_match /\/admin\/posts\/new/, response.body
    assert_no_match /\/admin\/typus_users\/new/, response.body
  end

end
