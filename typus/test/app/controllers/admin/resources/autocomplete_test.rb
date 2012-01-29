require "test_helper"

=begin

  What's being tested here?

    - Typus::Controller::Autocomplete

=end

class Admin::EntriesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
    FactoryGirl.create_list(:entry, 25)
  end

  test "autocomplete returns up to 20 items" do
    get :autocomplete, :search => "Entry"
    assert_response :success
    assert_equal 20, assigns(:items).size
  end

  test "autocomplete with a search result" do
    FactoryGirl.create(:entry, :title => "fesplugas", :id => 10000)
    get :autocomplete, :search => "fesp"
    assert_response :success
    assert assigns(:items).size.eql?(1)

    assert_match %Q["id":10000], response.body
    assert_match %Q["name":"fesplugas"], response.body
  end

  test "autocomplete with only a search result" do
    get :autocomplete, :search => "jmeiss"
    assert_response :success
    assert assigns(:items).empty?
    assert_equal "[]", response.body
  end

end
