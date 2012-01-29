# -*- coding: utf-8 -*-
class MissionMailer < ActionMailer::Base
  layout 'mailer_layouts/mailer'
  default from: "mission@weblab.com"

  #
  # When mission is broadcasted
  #
  def new_mission(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    mail(:to => user.email, :subject => 'Nouvelle mission - ' + mission.title)
  end

  #
  # When the user apply for a mission
  #
  def apply_confirmation(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    mail(:to => user.email, :subject => 'Vous avez bien postulé pour - ' + mission.title)
  end

  #
  # When the user is confirmed for the mission
  #
  def mission_confirmed_for_the_user(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    mail(:to => user.email, :subject => 'Vous avez été retenu pour - ' + mission.title)
  end
  
end
