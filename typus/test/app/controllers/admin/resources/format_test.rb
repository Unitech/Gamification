require "test_helper"

=begin

  What's being tested here?

    - Typus::Controller::Format

=end

class Admin::EntriesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
  end

  test "export csv" do
    Entry.delete_all
    entry = FactoryGirl.create(:entry)

    expected = <<-RAW
Title,Published
#{entry.title},#{entry.published}
     RAW

    get :index, :format => "csv"

    assert_response :success
    assert_equal expected, response.body
  end

  test "export XML" do
    get :index, :format => "xml"
    assert_response :unprocessable_entity
  end

end
