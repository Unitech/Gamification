# -*- coding: utf-8 -*-
class Admin::MissionsController < Admin::ResourcesController
  
   def index
    get_objects

    custom_actions_for(:index).each do |action|
       prepend_resources_action(action.titleize, {:action => action, :id => nil})
    end

    respond_to do |format|
       format.html do
         #set_default_action
         add_resource_action("Show", {:action => "show"}, {})
         add_resource_action("Broadcast", {:action => "send_mail_to_users"}, {:confirm => 'Êtes vous sur de vouloir broadcaster par mail cette mission ?'}) 
         #add_resource_action("Trash", {:action => "destroy"}, {:confirm => "#{Typus::I18n.t("Trash")}?", :method => 'delete'})
        generate_html
      end

       %w(json xml csv).each { |f| format.send(f) { send("generate_#{f}") } }
    end
  end

  # def index
  #   #get_objects
  #   add_resource_action("Broadcast", {:action => "send_mail_to_users"}, {:confirm => 'Êtes vous sur de vouloir broadcaster par mail cette mission ?'}) 
  #   prepend_resource_action("Show", {:action => "show"}, {})
  #   super
  # end

  def show
    prepend_resource_action("Show", {:action => "show"}, {})
    super
  end

  def show_interested_user
    @missions = Mission.pending_missions
  end

  def send_mail_to_users
    mission = Mission.find(params[:id].to_i)
    
    i = 0
    #
    # delayed_job !
    #
    User.all.each do |u|
      MissionMailer.new_mission(u, mission).deliver
      i = i + 1
    end

    flash[:success] = i.to_s + " mails ont bien été envoyés"
    redirect_to :back
  end

  def choose_user

  end
end
