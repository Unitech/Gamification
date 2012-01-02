class Admin::MissionsController < Admin::ResourcesController
  def show_pending_missions
    @missions = Mission.pending_missions
  end
  
end
