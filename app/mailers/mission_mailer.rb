class MissionMailer < ActionMailer::Base
  layout 'mailer_layouts/mailer'
  default from: "mission@weblab.com"

  def new_mission(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    mail(:to => user.email, :subject => 'Nouvelle mission - ' + mission.title)
  end

  def apply_confirmation(user, mission)
    @user = user
    @mission = mission
    @url_site = URL_SITE
    mail(:to => user.email, :subject => 'Postulation ok pour - ' + mission.title)
  end

end
