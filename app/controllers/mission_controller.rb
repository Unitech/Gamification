# -*- coding: utf-8 -*-
class MissionController < ApplicationController
  before_filter :authenticate_user!

  def mission_detail
    @mission = Mission.find(params[:mission_id], :include => [:comments])
    @comment = Comment.new    
  end

  def apply_for_mission
    mission = Mission.find(params[:mission_id].to_i)

    if mission.attach_new_user current_user
      MissionMailer.apply_confirmation(current_user, 
                                       Mission.find(mission.id)).deliver
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end

  def waiting_missions
    @waiting_missions = Mission
      .paginate(:page => params[:page], :per_page => 5)      
      .user_waiting_missions(current_user)
      .includes(:comments)
  end

  def finished_missions
    @finished_missions = Mission
      .paginate(:page => params[:page], :per_page => 5)
      .user_finished_missions(current_user)
      .includes(:comments)
  end

  def available_missions
    #if current_user.missions.present?
      @missions = Mission.available_for_user current_user
      @missions = @missions.paginate(:page => params[:page], :per_page => 5) 
    #   else
    #   @missions = Mission
    #     .includes(:comments)
    #     .order('begin_date ASC')
    #     .paginate(:page => params[:page], :per_page => 5) 
    # end
  end
  
  def submit_comment
    mission = Mission.find(params[:comment][:mission])
    comment = Comment.new(:content => params[:comment][:content],
                          :user => current_user,
                          :mission => mission)
    if comment.save
      redirect_to :back, :info => 'Votre commentaire a bien été posté'
      return
    else
      render :action => 'mission_detail'
      return 
    end
  end

end
