require "test_helper"

=begin

  Here we test:

  - Typus::Orm::ActiveRecord::User::InstanceMethods
  - Typus::Orm::ActiveRecord::User::InstanceMethodsMore

=end

class DeviseUserTest < ActiveSupport::TestCase

  test "to_label" do
    user = FactoryGirl.build(:devise_user)
    assert_equal user.email, user.to_label
  end

  test "can?" do
    user = FactoryGirl.build(:devise_user)
    assert user.can?('delete', TypusUser)
    assert !user.cannot?('delete', TypusUser)
    assert user.can?('delete', 'TypusUser')
    assert !user.cannot?('delete', 'TypusUser')
  end

  test "is_root?" do
    user = FactoryGirl.build(:devise_user)
    assert user.is_root?
    assert !user.is_not_root?
  end

  test "role" do
    user = FactoryGirl.build(:devise_user)
    assert_equal "admin", user.role
  end

  test "locale" do
    user = FactoryGirl.build(:devise_user)
    assert_equal :en, user.locale
  end

end
