class Admin::SettingsController < Admin::BaseController

  before_filter :verify_role

  def index
  end

  def update
    params[:settings].each do |key, value|
      if setting = Admin::Setting.find_by_key(key)
        setting.update_attributes :value => value
      else
        Admin::Setting.create(:key => key, :value => value)
      end
    end

    flash[:notice] = Typus::I18n.t("Settings successfully updated.")
    redirect_to :action => "index"
  end

  private

  def verify_role
    redirect_to admin_dashboard_index_path if admin_user.is_not_root?
  end

end
