require "test_helper"

=begin

  What's being tested here?

    - Stuff related to Admin users. (a.k.a. Profile Stuff)

=end

class Admin::TypusUsersControllerTest < ActionController::TestCase

  context "Admin" do

    setup do
      admin_sign_in
      @typus_user_editor = FactoryGirl.create(:typus_user, :email => "editor@example.com", :role => "editor")
      @request.env['HTTP_REFERER'] = '/admin/typus_users'
    end

    should "be able to render new" do
      get :new
      assert_response :success
    end

    should "not be able to toogle his status" do
      get :toggle, { :id => @typus_user.id, :field => 'status' }
      assert_response :unprocessable_entity
    end

    should "be able to toggle other users status" do
      get :toggle, { :id => @typus_user_editor.id, :field => 'status' }
      assert_response :redirect
      assert_redirected_to @request.env['HTTP_REFERER']
      assert_equal "Typus user successfully updated.", flash[:notice]
    end

    should "not be able to destroy himself" do
      delete :destroy, :id => @typus_user.id
      assert_response :unprocessable_entity
    end

    should "be able to destroy other users" do
      assert_difference('TypusUser.count', -1) do
        delete :destroy, :id => @typus_user_editor.id
      end

      assert_response :redirect
      assert_redirected_to @request.env['HTTP_REFERER']
      assert_equal "Typus user successfully removed.", flash[:notice]
    end

    should "be able to update his profile" do
      post :update, :id => @typus_user.id, :typus_user => { :first_name => "John", :last_name => "Locke", :role => 'admin', :status => '1' }, :_save => true
      assert_response :redirect
      assert_redirected_to "/admin/typus_users"
      assert_equal "Typus user successfully updated.", flash[:notice]
      assert_equal "John Locke", @typus_user.reload.to_label
    end

    should "not be able to change his role" do
      post :update, :id => @typus_user.id, :typus_user => { :role => 'editor' }, :_save => true
      assert_response :unprocessable_entity
    end

    should "not be able to change his status" do
      post :update, :id => @typus_user.id, :typus_user => { :status => '0' }, :_save => true
      assert_response :unprocessable_entity
    end

    should "be able to update other users role" do
      post :update, :id => @typus_user_editor.id, :typus_user => { :role => 'admin' }, :_save => true
      assert_response :redirect
      assert_redirected_to "/admin/typus_users"
      assert_equal "Typus user successfully updated.", flash[:notice]
    end

  end

  context "Editor" do

    setup do
      editor_sign_in
      @request.env['HTTP_REFERER'] = '/admin/typus_users'
    end

    should "not be able  to create typus_users" do
      get :new
      assert_response :unprocessable_entity
    end

    should "be able to edit his profile" do
      get :edit, :id => @typus_user.id
      assert_response :success
    end

    should "be able to update his profile" do
      post :update, :id => @typus_user.id, :typus_user => { :role => 'editor' }, :_continue => true
      assert_response :redirect
      assert_redirected_to "/admin/typus_users/edit/#{@typus_user.id}"
      assert_equal "Typus user successfully updated.", flash[:notice]
    end

    should "not be able to change his role" do
      post :update, :id => @typus_user.id, :typus_user => { :role => 'admin' }, :_continue => true
      assert_response :redirect
      assert_redirected_to "/admin/typus_users/edit/#{@typus_user.id}"
      assert_equal "editor", @typus_user.role
    end

    should "not be able to destroy his profile" do
      delete :destroy, :id => @typus_user.id
      assert_response :unprocessable_entity
    end

    should "not be able to toggle his status" do
      get :toggle, { :id => @typus_user.id, :field => 'status' }
      assert_response :unprocessable_entity
    end

    should "not be able to edit other profiles" do
      get :edit, :id => FactoryGirl.create(:typus_user).id
      assert_response :unprocessable_entity
    end

    should "not be able to update other profiles" do
      post :update, :id => FactoryGirl.create(:typus_user).id, :typus_user => { :role => 'admin' }
      assert_response :unprocessable_entity
    end

    should "not be able to destroy other profiles" do
      delete :destroy, :id => FactoryGirl.create(:typus_user).id
      assert_response :unprocessable_entity
    end

    should "not be able to toggle other profiles status" do
      get :toggle, :id => FactoryGirl.create(:typus_user).id, :field => 'status'
      assert_response :unprocessable_entity
    end

  end

  ##
  # Designer doesn't have TypusUser permissions BUT can update his profile.
  #

  context "Designer" do

    setup do
      designer_sign_in
    end

    should "be able to edit his profile" do
      get :edit, :id => @typus_user.id
      assert_response :success
    end

    should "be able to update his profile" do
      post :update, :id => @typus_user.id, :typus_user => { :role => 'designer', :email => 'designer@withafancydomain.com' }, :_save => true

      assert_response :redirect
      assert_redirected_to "/admin/typus_users"
      assert_equal "Typus user successfully updated.", flash[:notice]
      assert_equal "designer@withafancydomain.com", assigns(:item).email
    end

  end

end
