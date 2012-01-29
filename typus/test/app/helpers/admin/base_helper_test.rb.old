require "test_helper"

class Admin::BaseHelperTest < ActiveSupport::TestCase

  include Admin::BaseHelper

  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper

  def render(*args); args; end

  context "login info" do

    setup do
      admin_user = mock
      self.stubs(:admin_user).returns(admin_user)
      admin_user.stubs(:name).returns("Admin")
      admin_user.stubs(:id).returns(1)
    end

    should "skip rendering when we're using a fake user" do
      admin_user.stubs(:is_a?).with(FakeUser).returns(true)
      output = login_info
      assert_nil output
    end

    context "when the current user is not a FakeUser" do

      setup do
        admin_user.stubs(:is_a?).with(FakeUser).returns(false)
      end

      context "when the user cannot edit his informations" do

        should "render a partial with the user name" do
          admin_user.stubs(:can?).with('edit', 'TypusUser').returns(false)
          assert_equal ["helpers/admin/base/login_info"], login_info
        end

      end

      context "when the user can edit his informations" do

        should "render a partial with a link" do
          link_options = { :action => 'edit', :controller => '/admin/typus_users', :id => 1 }

          admin_user.stubs(:can?).with('edit', 'TypusUser').returns(true)
          self.stubs(:link_to).with("Admin", link_options).returns(%(<a href="/admin/typus_users/edit/1">Admin</a>))

          assert_equal ["helpers/admin/base/login_info"], login_info
        end

      end

    end

  end

  test "header returns a partial" do
    expected = ["helpers/admin/base/header", {:admin_title=>"Typus"}]
    assert_equal expected, header
  end

  test "display_flash_message is displayed" do
    message = { :test => "This is the message." }
    output = display_flash_message(message)
    expected = ["helpers/admin/base/flash_message",
                { :flash_type => :test, :message => { :test => "This is the message." } }]
    assert_equal expected, output
  end

  test "display_flash_message is not displayed when message is empty" do
    assert_nil display_flash_message(Hash.new)
  end

end
