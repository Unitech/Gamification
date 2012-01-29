class Admin::DashboardController < Admin::BaseController

  def index; end

  def show
    render params[:application].parameterize
  rescue ActionView::MissingTemplate
    render "index"
  end

end
