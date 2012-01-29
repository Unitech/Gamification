class Admin::BaseController < ActionController::Base

  include Typus::Authentication::const_get(Typus.authentication.to_s.classify)

  before_filter :reload_config_and_roles
  before_filter :authenticate
  before_filter :set_locale

  helper_method :admin_user
  helper_method :current_role

  protected

  def reload_config_and_roles
    Typus.reload! if Rails.env.development?
  end

  def set_locale
    I18n.locale = if admin_user && admin_user.respond_to?(:locale)
      admin_user.locale
    else
      Typus::I18n.default_locale
    end
  end

  def zero_users
    Typus.user_class.count.zero?
  end

  def not_allowed
    render :text => "Not allowed!", :status => :unprocessable_entity
  end

end
