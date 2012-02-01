# -*- coding: utf-8 -*-
class UserController < ApplicationController
  def private_profile
    
  end

  def pulic_profile
  end
  
  def account_historic
    @historic = current_user.wallet_operation.order('created_at DESC')
    @actions = current_user.entr_mission_users


  end
end
