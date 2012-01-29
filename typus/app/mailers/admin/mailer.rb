class Admin::Mailer < ActionMailer::Base

  default :from => Typus.mailer_sender

  def reset_password_instructions(user)
    @user = user

    options = { :to => user.email,
                :subject => "[#{Typus.admin_title}] #{Typus::I18n.t("Reset password")}" }

    mail(options) do |format|
      format.text
      format.html
    end
  end

end
