require "test_helper"

=begin

  What's being tested here?

    - Typus::Controller::ActsAsList

=end

class Admin::CategoriesControllerTest < ActionController::TestCase

  setup do
    admin_sign_in
    @request.env['HTTP_REFERER'] = '/admin/categories'
  end

  test "get position" do
    first_category = FactoryGirl.create(:category, :position => 1)
    second_category = FactoryGirl.create(:category, :position => 2)

    second_category.name = nil
    second_category.save(:validate => false)

    get :position, :id => first_category.id, :go => 'move_lower'
    assert_response :redirect
    assert_redirected_to @request.env['HTTP_REFERER']

    get :position, :id => first_category.id, :go => 'move_lower'
    assert_equal "Category successfully updated.", flash[:notice]
    assert assigns(:item).position.eql?(2)

    get :position, :id => second_category.id, :go => 'move_higher'
    assert assigns(:item).position.eql?(1)

    get :position, :id => first_category.id, :go => 'move_to_bottom'
    assert assigns(:item).position.eql?(2)

    get :position, :id => second_category.id, :go => 'move_to_top'
    assert assigns(:item).position.eql?(1)
  end

  test "get position with not allowed go option" do
    category = FactoryGirl.create(:category, :position => 1)
    get :position, :id => category.id, :go => 'move_up'
    assert_response :unprocessable_entity
    assert_equal "Not allowed!", response.body
  end

end
