require "test_helper"

=begin

  What's being tested here?

    - Typus::Controller::Trash

=end

class Admin::EntryTrashesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
    @entry = FactoryGirl.create(:entry_trash)
  end

  test "get index shows link to trash" do
    pending
  end

  test "get index does not show link to trash when user does not have edit access" do
    pending
  end

  test "get trash lists destroyed items" do
    get :trash
    assert assigns(:items).empty?

    @entry.destroy
    get :trash
    assert_response :success
    assert_template 'admin/resources/index'
    assert_equal [@entry], assigns(:items)
  end

  test "get trash return error when user does not have edit access" do
    pending
  end

  test "get restore recovers an item from the trash" do
    @request.env['HTTP_REFERER'] = "/admin/entries/trash"

    @entry.destroy
    get :restore, :id => @entry.id
    assert_response :redirect
    assert_redirected_to @request.env['HTTP_REFERER']

    get :trash
    assert assigns(:items).empty?
  end

  test "get restore returns error when user does not have edit access" do
    pending
  end

end
