require './test/test_helper'

class Admin::MissionsIntegrationTest < ActionController::IntegrationTest

  def setup
    typus_login
    a = Factory :mission, :title => 'Mission test'
    @mission_id = a.id
    visit '/admin/missions'
  end

  test "check if show exist" do
    within '#mission_' + @mission_id.to_s do
      click_link 'Show'
    end
  end

  test "check if broadcast exist" do
    within '#mission_' + @mission_id.to_s do
      assert_contain 'Broadcast'
    end
  end

end
