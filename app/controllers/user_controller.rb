# -*- coding: utf-8 -*-
class UserController < ApplicationController
  def private_profile
    @actions = current_user.entr_mission_users
      .order('updated_at DESC')
  end

  def public_profile
    @user = User.search_by_username params[:username]
  end
  
  def account_historic
    @historic = current_user.wallet_operation.order('created_at DESC')
  end

  def actions_historic
    @actions = current_user.entr_mission_users
      .order('updated_at DESC')
      .includes(:mission)
  end
end
