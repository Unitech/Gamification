# -*- coding: utf-8 -*-
module MissionHelper
  
  #
  # Fill all yield for the meta page mission/mission_detail.html.erb
  #
  # = yield button_style
  # = yield many_user     // If other users are linked to the mission
  #
  def fill_page
    case current_user.has_link_with_mission(@mission.id)
      
    when EntrMissionUser::Status::APPLIED
      content_for :button_style do
        link_to 'En attente de confirmation', '#/', :class => 'button apply-btn', :title => "Vous avez postulé pour cette mission, le laboratoire est entrain de délibérer. Vous serez contacté via mail dans les plus brefs délais."
      end
   
      #
      # Mission is in action !
      #
    when EntrMissionUser::Status::CONFIRMED
      content_for :button_style do
        link_to 'La mission est en cours', '#/', :class => 'button apply-btn', :title => "Vous avez postulé pour cette mission, le laboratoire est entrain de délibérer. Vous serez contacté via mail dans les plus brefs délais."
     end

   when EntrMissionUser::Status::DONE
     content_for :button_style do
       link_to 'La mission est terminée', '#/', :class => 'button apply-btn', :title => "Vous avez postulé pour cette mission, le laboratoire est entrain de délibérer. Vous serez contacté via mail dans les plus brefs délais."
     end


   else
     content_for :button_style do
       link_to 'Postuler', '#/apply', :class => 'button apply-btn apply-action', :title => "Vous êtes interessé par cette mission ? Postulez ! Votre dossier sera envoyé aux administrateurs du laboratoire et vous serez tenu vite au courant de l'avancée de votre candidature !"
     end
   end
  end
end
