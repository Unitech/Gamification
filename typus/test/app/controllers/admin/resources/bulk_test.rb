require "test_helper"

=begin

  What's being tested here?

    - Typus::Controller::Trash

=end

class Admin::EntryBulksControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
  end

  test "get index shows available bulk_actions" do
    get :index
    assert_equal [["Move to Trash", "bulk_destroy"]], assigns(:bulk_actions)
  end

  test "get bulk_destroy removes all items" do
    @request.env['HTTP_REFERER'] = "/admin/entry_bulks"

    FactoryGirl.create_list(:entry_bulk, 10)
    items_to_destroy = EntryBulk.limit(5).map(&:id)
    items_to_keep = EntryBulk.limit(5).offset(5).map(&:id)

    get :bulk, :batch_action => "bulk_destroy", :selected_item_ids => items_to_destroy
    assert_response :redirect
    assert_redirected_to @request.env['HTTP_REFERER']

    assert_equal items_to_keep, EntryBulk.all.map(&:id)
  end

  test "get bulk with empty action and selected items redirects to back with a feedback message" do
    @request.env['HTTP_REFERER'] = "/admin/entry_bulks"

    FactoryGirl.create_list(:entry_bulk, 5)
    items = EntryBulk.limit(5).map(&:id)

    get :bulk, :batch_action => "", :selected_item_ids => items
    assert_response :redirect
    assert_redirected_to @request.env['HTTP_REFERER']

    assert_equal "No bulk action selected.", flash[:notice]
  end

end
