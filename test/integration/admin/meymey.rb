require './test/test_helper'

class Admin::Meymey < ActionController::IntegrationTest
  def setup
    typus_login
  end

  test "this is a test sisi" do
    #raise 'das'
    visit '/admin/dashboard'
    click_link 'Comments'
  end
end
