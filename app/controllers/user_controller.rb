# -*- coding: utf-8 -*-
class UserController < ApplicationController
  def private_profile
  
  end

  def pulic_profile
  end
  
  def account_historic
      @historic = current_user.wallet_operation
  end
end
