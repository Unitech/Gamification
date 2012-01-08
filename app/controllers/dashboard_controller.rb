require 'will_paginate/array'

class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def home
    # little hack for pagination

    @missions = Mission.user_todo_missions current_user
    @missions = @missions
      .paginate(:page => params[:page], :per_page => 5)

    @waiting_missions = Mission.user_pending_missions current_user
    @waiting_missions = @waiting_missions
      .paginate(:page => params[:page], :per_page => 5)

    @canceled_missions = Mission.user_canceled_missions current_user
    @canceled_missions = @canceled_missions
      .paginate(:page => params[:page], :per_page => 5)
  end
  
end
