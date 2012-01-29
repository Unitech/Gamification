require "test_helper"

=begin

  Here we test:

  - Typus::Orm::ActiveRecord::AdminUserV1

=end

class TypusUserTest < ActiveSupport::TestCase

  test "validate email" do
    assert FactoryGirl.build(:typus_user, :email => "dong").invalid?
    assert FactoryGirl.build(:typus_user, :email => "john@example.com").valid?
    assert FactoryGirl.build(:typus_user, :email => nil).invalid?
  end

  test "validate :role" do
    assert FactoryGirl.build(:typus_user, :role => nil).invalid?
  end

  test "validate :password" do
    assert FactoryGirl.build(:typus_user, :password => "0"*5).invalid?
    assert FactoryGirl.build(:typus_user, :password => "0"*6).valid?
    assert FactoryGirl.build(:typus_user, :password => "0"*40).valid?
    assert FactoryGirl.build(:typus_user, :password => "0"*41).invalid?
  end

  test "status is protected from mass_assignment" do
    assert TypusUser.attr_protected[:default].include?(:status)
  end

  test "fields" do
    expected = %w(id first_name last_name email role status salt crypted_password token preferences created_at updated_at).sort
    output = TypusUser.columns.map(&:name).sort
    assert_equal expected, output
  end

  test "generate" do
    assert !TypusUser.generate

    options = { :email => FactoryGirl.build(:typus_user).email }
    typus_user = TypusUser.generate(options)
    assert_equal options[:email], typus_user.email

    typus_user_factory = FactoryGirl.build(:typus_user)
    options = { :email => typus_user_factory.email, :password => typus_user_factory.password }
    typus_user = TypusUser.generate(options)
    assert_equal options[:email], typus_user.email

    typus_user_factory = FactoryGirl.build(:typus_user)
    options = { :email => typus_user_factory.email, :role => typus_user_factory.role }
    typus_user = TypusUser.generate(options)
    assert_equal options[:email], typus_user.email
    assert_equal options[:role], typus_user.role
  end

  context "TypusUser" do

    setup do
      @typus_user = FactoryGirl.create(:typus_user)
    end

    should "verify salt never changes" do
      expected = @typus_user.salt
      @typus_user.update_attributes(:password => '11111111', :password_confirmation => '11111111')
      assert_equal expected, @typus_user.salt
    end

    should "verify authenticated? returns true or false" do
      assert @typus_user.authenticated?('12345678')
      assert !@typus_user.authenticated?('87654321')
    end

    should "verify preferences are nil by default" do
      assert @typus_user.preferences.nil?
    end

    should "return default_locale when no preferences are set" do
      assert @typus_user.locale.eql?(:en)
    end

    should "be able to set a locale" do
      @typus_user.locale = :jp

      expected = {:locale => :jp}
      assert_equal expected, @typus_user.preferences
      assert @typus_user.locale.eql?(:jp)
    end

    should "be able to set preferences" do
      @typus_user.preferences = {:chunky => "bacon"}
      assert @typus_user.preferences.present?
    end

    should "set locale preference without overriding previously set preferences" do
      @typus_user.preferences = {:chunky => "bacon"}
      @typus_user.locale = :jp

      expected = {:locale => :jp, :chunky => "bacon"}
      assert_equal expected, @typus_user.preferences
    end

  end

  test "to_label" do
    user = FactoryGirl.build(:typus_user)
    assert_equal user.email, user.to_label

    user = FactoryGirl.build(:typus_user, :first_name => "John")
    assert_equal "John", user.to_label

    user = FactoryGirl.build(:typus_user, :last_name => "Locke")
    assert_equal "Locke", user.to_label

    user = FactoryGirl.build(:typus_user, :first_name => "John", :last_name => "Locke")
    assert_equal "John Locke", user.to_label
  end

  test "admin gets a list of all applications" do
    typus_user = FactoryGirl.build(:typus_user)
    assert_equal Typus.applications, typus_user.applications
  end

=begin
  # TODO: Decide if we want this test ...
  test "admin gets a list of application resources for crud extended application" do
    typus_user = FactoryGirl.build(:typus_user)
    # OPTIMIZE: There's no need to sort stuff but this is required to make it
    #           work with Ruby 1.8.7.
    expected = %w(Asset Case Comment EntryDefault Page Post Article::Entry ReadOnlyEntry).sort
    assert_equal expected, typus_user.application("CRUD Extended").sort
  end
=end

  test "admin gets a list of application resources for Admin application" do
    typus_user = FactoryGirl.build(:typus_user)
    # OPTIMIZE: There's no need to sort stuff but this is required to make it
    #           work with Ruby 1.8.7.
    expected = %w(AdminUser TypusUser DeviseUser).sort
    assert_equal expected, typus_user.application("Admin").sort
  end

  test "editor get a list of all applications" do
    typus_user = FactoryGirl.build(:typus_user, :role => "editor")
    expected = ["Admin", "CRUD Extended"]
    expected.each { |e| assert Typus.applications.include?(e) }
  end

  test "editor gets a list of application resources" do
    typus_user = FactoryGirl.build(:typus_user, :role => "editor")
    assert_equal %w(Comment Post), typus_user.application("CRUD Extended")
    assert typus_user.application("Admin").empty?
  end

  test "user owns a resource" do
    typus_user = FactoryGirl.build(:typus_user)
    resource = FactoryGirl.build(:post, :typus_user => typus_user)
    assert typus_user.owns?(resource)
  end

  test "user does not own a resource" do
    typus_user = FactoryGirl.create(:typus_user)
    resource = FactoryGirl.create(:post, :typus_user => FactoryGirl.create(:typus_user))
    assert !typus_user.owns?(resource)
  end

  test "token changes everytime we save the user" do
    admin_user = FactoryGirl.create(:typus_user)
    first_token = admin_user.token
    admin_user.save
    second_token = admin_user.token
    assert !first_token.eql?(second_token)
  end

end
