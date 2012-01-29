# -*- coding: utf-8 -*-
class Admin::EntrMissionUsersController < Admin::ResourcesController

  #
  # APPLIED -> CONFIRMED
  #
  def confirm_user
    mission_link = EntrMissionUser.find(params[:id])
    mission_link.state = EntrMissionUser::Status::CONFIRMED
    mission_link.save
    

    #
    # Switch all other members status who applied to CANCELED (deprecated)
    #

    # canceled_missions = EntrMissionUser.where("mission_id = ? AND state = ? ", 
    #                                           mission_link.mission_id,
    #                                           EntrMissionUser::Status::APPLIED)
    # canceled_missions.each do |canc|
    #   canc.state = EntrMissionUser::Status::CANCELED
    #   canc.save
    # end

    user = mission_link.user
    mission = mission_link.mission
    
    mission.state = Mission::Status::CONFIRMED
    mission.save

    MissionMailer.mission_confirmed_for_the_user(user, mission).deliver

    flash[:success] = user.to_s + " bien confirmé pour " + mission.to_s
    redirect_to :back
  end

  #
  # CONFIRMED -> APPLIED
  #
  def undo_confirmation
    mission_link = EntrMissionUser.find(params[:id])
    mission_link.state = EntrMissionUser::Status::APPLIED
    mission_link.save

    flash[:success] = mission_link.user.to_s + "  a passé sa relation en attente"
    redirect_to :back
  end

  #
  # X -> CANCELED
  #
  def cancel_user
    mission_link = EntrMissionUser.find(params[:id])
    mission_link.state = EntrMissionUser::Status::CANCELED
    mission_link.save

    flash[:success] = mission_link.user.to_s + "  a passé sa relation en attente"
    redirect_to :back
  end
end
