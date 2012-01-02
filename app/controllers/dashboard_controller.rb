class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def home
    @missions = Mission
      .includes(:comments)
      .order('begin_date ASC')
      .where('id in (?)', current_user.missions.map(&:id))
      .paginate(:page => params[:page], :per_page => 5)      
  end

  
end
