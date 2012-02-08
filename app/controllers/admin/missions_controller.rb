# -*- coding: utf-8 -*-
class Admin::MissionsController < Admin::ResourcesController
  def index
    get_objects

    custom_actions_for(:index).each do |action|
      prepend_resources_action(action.titleize, {:action => action, :id => nil})
    end
    
    #raise @resource_actions.inspect
    
    respond_to do |format|
      format.html do
        #set_default_action
        add_resource_action("Show", {:action => "show"}, {})
        add_resource_action("Broadcast", {:action => "send_mail_to_users"}, {:confirm => 'Êtes vous sur de vouloir broadcaster par mail cette mission ?'}) 
        add_resource_action("Set as finished", {:action => "set_mission_as_done"}, {:confirm => 'Êtes vous sur de confirmer la fin de cette mission ?'}) 
        add_resource_action("<span style='color:red'>Trash</span>".html_safe, {:action => "destroy"}, {:confirm => "#{Typus::I18n.t("Trash")}?", :method => 'delete'})
        generate_html
      end
      
      %w(json xml csv).each { |f| format.send(f) { send("generate_#{f}") } }
    end
  end
  
  def show
    #
    # Actions for nested ressources
    #
    add_resource_action("Show", 
                        {:action => "show", :_popup => true}, {:class => 'iframe'} )

    add_resource_action("Edit", 
                        {:action => :edit, :_popup => true}, {:class => 'iframe_with_page_reload'})
 
    #
    # /!\ it redirects to the action confirm_user of entr_mission_users_controller
    #
    add_resource_action("<span style='color : green'>Confirm user</span>".html_safe, 
                        {:action => "confirm_user", :mission_id => params[:id]}, {})
    
    add_resource_action("<span style='color : OrangeRed'>Undo confirmation</span>".html_safe, 
                        {:action => "undo_confirmation", :mission_id => params[:id]}, {})
    
    add_resource_action("<span style='color : red'>Cancel user</span>".html_safe, 
                        {:action => "cancel_user", :mission_id => params[:id]}, {})
    super
  end

  #
  # Finish mission (change entr_mission_user and mission status + send mail to each user + credit user accounts)
  #
  def set_mission_as_done
    mission = Mission.find(params[:id].to_i)
    entr_missions = mission.entr_mission_users

    # No users attached to the mission
    if entr_missions.empty?
      flash[:success] = "<h2>La mission < #{mission.title} > <span style='color:red'>ne peut pas être terminée (aucun utilisateur)</span></h2>".html_safe
      redirect_to :back
      return
    end
    
    # Set each user link as done
    entr_missions.each do |entr|
      # If the user was doing the mission
      if entr.state == EntrMissionUser::Status::CONFIRMED
        # Credit him
        entr.user.credit_user mission
      end
      entr.state = EntrMissionUser::Status::DONE
      entr.save
    end
    
    # Set mission state as finished
    mission.state = Mission::Status::FINISHED
    mission.save

    # End
    flash[:success] = "<h2>La mission < #{mission.title} > a bien été terminée</h2>".html_safe
    redirect_to :back
  end

  #
  # BROADCAST functionnality
  #
  def send_mail_to_users
    mission = Mission.find(params[:id].to_i)

    i = 0
    #
    # Send mail to each user (must use delayed_job !)
    #
    # User.all.each do |u|
    #   MissionMailer.new_mission(u, mission).deliver
    #   i = i + 1
    # end
    MissionMailer.broadcast_new_mission(mission).deliver
    
    
    flash[:success] = "Les mails ont bien été envoyés"
    redirect_to :back
  end

  def choose_user

  end
end
