class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def home
    @missions = Mission
      .paginate(:page => params[:page], :per_page => 5)
      .todo_missions(current_user)
      .includes(:comments)

    @waiting_missions = Mission
      .paginate(:page => params[:page], :per_page => 5)      
      .waiting_missions(current_user)
      .includes(:comments)
      
  end
  
end
