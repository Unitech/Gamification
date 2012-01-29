require "test_helper"

=begin

  Here we test:

  - Typus::Orm::ActiveRecord::User::InstanceMethods

=end

class UserTest < ActiveSupport::TestCase

  test "to_label" do
    user = FactoryGirl.build(:user)
    assert_equal user.email, user.to_label
  end

  test "can?" do
    user = FactoryGirl.build(:user, :role => 'admin')
    assert user.can?('delete', TypusUser)
    assert !user.cannot?('delete', TypusUser)
    assert user.can?('delete', 'TypusUser')
    assert !user.cannot?('delete', 'TypusUser')
  end

  test "is_root?" do
    user = FactoryGirl.build(:user, :role => 'admin')
    assert user.is_root?
    assert !user.is_not_root?
  end

  test "active?" do
    user = FactoryGirl.build(:user, :role => 'admin', :status => true)
    assert user.active?

    user = FactoryGirl.build(:user, :role => 'admin', :status => false)
    assert !user.active?

    user = FactoryGirl.build(:user, :role => 'unexisting', :status => true)
    assert !user.active?

    user = FactoryGirl.build(:user, :role => 'unexisting', :status => false)
    assert !user.active?
  end

end
