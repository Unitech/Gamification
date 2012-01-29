require "test_helper"

class Admin::MailerTest < ActiveSupport::TestCase

  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  test "reset_password_instructions" do
    user = FactoryGirl.build(:typus_user, :token => "qswed3-64g3fb")
    mail = Admin::Mailer.reset_password_instructions(user)

    assert_nil Admin::Mailer.default[:from]
    assert mail.to.include?(user.email)

    expected = "[#{Typus.admin_title}] Reset password"
    assert_equal expected, mail.subject
    assert_equal "multipart/alternative", mail.mime_type

    assert_match admin_account_url(user.token), mail.body.encoded
  end

end
