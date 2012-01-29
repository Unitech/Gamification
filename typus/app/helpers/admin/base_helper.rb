module Admin::BaseHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def header
    locals = { :admin_title => admin_title }
    render "helpers/admin/base/header", locals
  end

  def admin_title
    setting = defined?(Admin::Setting) && Admin::Setting.admin_title
    setting || Typus.admin_title
  end

  def has_root_path?
    Rails.application.routes.routes.map(&:name).include?("root")
  end

  def apps
    render "helpers/admin/base/apps"
  end

  def login_info
    render "helpers/admin/base/login_info" unless admin_user.is_a?(FakeUser)
  end

  def admin_sign_out_path
    case Typus.authentication
    when :devise
      send("destroy_#{Typus.user_class_name.underscore}_session_path")
    else
      destroy_admin_session_path
    end
  end

  def display_flash_message(message = flash)
    if message.keys.any?
      locals = { :flash_type => message.keys.first, :message => message }
      render "helpers/admin/base/flash_message", locals
    end
  end

end
