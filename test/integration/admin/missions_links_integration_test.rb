require './test/test_helper'

class Admin::MissionsLinksIntegrationTest < ActionController::IntegrationTest

  def setup
    typus_login

    mission_fact = Factory :mission, :title => 'Mission test'
    @mission = Mission.find(mission_fact.id)
    
    @user_1 = User.create(:f_name => Faker::Name.first_name,
                      :l_name => Faker::Name.last_name, 
                      :username => Faker::Name.name,
                      :email => Faker::Internet.email,
                      :password => '123456')
    @user_2 = User.create(:f_name => Faker::Name.first_name,
                      :l_name => Faker::Name.last_name, 
                      :username => Faker::Name.name,
                      :email => Faker::Internet.email,
                      :password => '123456')

    assert_difference "EntrMissionUser.count", 2 do
      @mission.attach_new_user @user_1
      @mission.attach_new_user @user_2      
    end

    visit '/admin/missions'
  end

  test "check if mission created" do
    within '#mission_' + @mission.id.to_s do
      click_link 'Show'
    end
  end

  test "check if user linked to mission" do
    visit '/admin/missions/show/' + @mission.id.to_s

    assert_contain @user_1.to_s
    assert_contain @user_2.to_s
  end

  test "confirm user for mission" do
    visit '/admin/missions/show/' + @mission.id.to_s
    
    entr = EntrMissionUser.where(:user_id => @user_1.id).first
    entr_2 = EntrMissionUser.where(:user_id => @user_2.id).first

    within "#entr_mission_user_" + entr.id.to_s do
      click_link "Confirm user"
    end
    
    within "#entr_mission_user_" + entr.id.to_s do
      assert_contain 'Confirmed'
    end

    within "#entr_mission_user_" + entr_2.id.to_s do
      assert_contain 'Canceled'
    end
  end

  
end
