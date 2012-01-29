require "test_helper"

=begin

  Here we test:

  - Typus::Orm::ActiveRecord::AdminUserV2
  - Typus::Orm::ActiveRecord::User::ClassMethods

=end

class AdminUserTest < ActiveSupport::TestCase

  test "token changes everytime we save the user" do
    admin_user = FactoryGirl.create(:admin_user)
    first_token = admin_user.token
    admin_user.save
    second_token = admin_user.token
    assert !first_token.eql?(second_token)
  end

  test "mass_assignment" do
    assert TypusUser.attr_protected[:default].include?(:status)
  end

  test "mapping locales" do
    admin_user = FactoryGirl.build(:admin_user, :locale => "en")
    assert_equal "English", admin_user.mapping(:locale)
  end

  test "locales" do
    assert_equal Typus::I18n.available_locales, AdminUser.locales
  end

  test "roles" do
    assert_equal Typus::Configuration.roles.keys.sort, AdminUser.roles
  end

  test "validate :password" do
    admin_user = FactoryGirl.build(:admin_user, :password => "00000")
    assert admin_user.invalid?
    assert_equal "is too short (minimum is 6 characters)", admin_user.errors[:password].first

    admin_user = FactoryGirl.build(:typus_user, :password => "000000")
    assert admin_user.valid?
  end

end
