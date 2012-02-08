# -*- coding: utf-8 -*-
class MissionMailer < ActionMailer::Base
  layout 'mailer_layouts/mailer'
  default from: "mission@weblab.com" 
  add_template_helper(ApplicationHelper)

  #
  # When mission is broadcasted (for all users (BCC))
  #
  def broadcast_new_mission(mission)
    @mission = mission
    @url_site = URL_SITE
    attachments.inline['logo.png'] = File.read('app/assets/images/logo-slogan-600.png')
    mail(:bcc => User.all.map(&:email), :subject => 'Nouvelle mission - ' + mission.title)
  end


  #
  # When mission is broadcasted (for one user)
  #
  def new_mission(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    attachments.inline['logo.png'] = File.read('app/assets/images/logo-slogan-600.png')
    mail(:to => user.email, :subject => 'Nouvelle mission - ' + mission.title)
  end

  #
  # When the user apply for a mission
  #
  def apply_confirmation(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    attachments.inline['logo.png'] = File.read('app/assets/images/logo-slogan-600.png')
    mail(:to => user.email, :subject => 'Vous avez bien postulé pour - ' + mission.title)
  end

  #
  # When the user is confirmed for the mission
  #
  def mission_confirmed_for_the_user(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    attachments.inline['logo.png'] = File.read('app/assets/images/logo-slogan-600.png')
    mail(:to => user.email, :subject => 'Vous avez été retenu pour - ' + mission.title)
  end

end
