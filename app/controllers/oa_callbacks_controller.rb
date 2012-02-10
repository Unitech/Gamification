##
## oa_callbacks_controller.rb
## Login : <elthariel@steel.labfree.lan>
## Started on  Thu Feb  9 17:56:26 2012 elthariel
## $Id$
##
## Author(s):
##  - elthariel <>
##
## Copyright (C) 2012 elthariel
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##

class OaCallbacksController < Devise::OmniauthCallbacksController
  def labz
    @user = User.find_for_labz_oauth(request.env["omniauth.auth"].info, current_user)

    if @user.persisted?
      flash[:notice] = "Successfully logged in with Labz credentials"
      sign_in @user
      redirect_to dashboard_home_path
    else
      session["devise.labz_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_path
    end
  end

  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
