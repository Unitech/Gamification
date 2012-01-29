require "test_helper"

class FakeUserTest < ActiveSupport::TestCase

  setup do
    @fake_user = FakeUser.new
  end

  should "have the id set to 0" do
    assert @fake_user.id.eql?(0)
  end

  should "be able to do anything" do
    assert @fake_user.can?("sing")
    assert !@fake_user.cannot?("sing")
  end

  should "have a locale" do
    assert_equal ::I18n.locale, @fake_user.locale
  end

  should "have status set to true" do
    assert @fake_user.status
  end

  should "be considered as root" do
    assert @fake_user.is_root?
  end

  should "not be considered as no_root" do
    assert !@fake_user.is_not_root?
  end

  should "have access to all applications" do
    assert_equal Typus.applications, @fake_user.applications
  end

  test "FakeUser#application" do
    assert_equal Typus.application("CRUD"), @fake_user.application("CRUD")
    # OPTIMIZE: There's no need to sort stuff but this is required to make it
    #           work with Ruby 1.8.7.
    expected = %w(Animal Bird Dog ImageHolder).sort
    assert_equal expected, @fake_user.application("Polymorphic").sort
  end

  should "be master_role" do
    assert_equal Typus.master_role, @fake_user.role
  end

  should "not respond to resources" do
    assert !@fake_user.respond_to?(:resources)
  end

  should "always be the owner of a resource" do
    assert @fake_user.owns?('a')
  end

end
