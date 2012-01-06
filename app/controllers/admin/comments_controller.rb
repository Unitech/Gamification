# -*- coding: utf-8 -*-

class Admin::CommentsController < Admin::ResourcesController
  
  # def show
  #   raise 'adsd'
  # end

  # def show_interested_user
  #   @missions = Mission.pending_missions

  # end

  # def send_mail_to_users
  #   mission = Mission.find(params[:id].to_i)
    
  #   i = 0
  #   #
  #   # delayed_job !
  #   #
  #   User.all.each do |u|
  #     MissionMailer.new_mission(u, mission).deliver
  #     i = i + 1
  #   end

  #   flash[:success] = i.to_s + " mails ont bien été envoyés"
  #   redirect_to :back
  # end

end
