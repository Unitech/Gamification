##
## labz.rb
## Login : <elthariel@steel.labfree.lan>
## Started on  Thu Feb  9 17:09:50 2012 elthariel
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

module OmniAuth
  module Strategies
    class Labz < OmniAuth::Strategies::OAuth
      option :name, 'labz'
      option :client_options, {
        :site => 'http://steel:3001',
        :scheme => :header
      }

      uid { raw_info['uid'] }

      info do
        {
          'uid'   => raw_info['uid'],
          'login'  => raw_info['login'],
          'login_mail'  => "#{raw_info['login']}@epitech.net",
          'email' => raw_info['email']
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def raw_info
        @raw_info ||= JSON.parse(access_token.get('/users/me.json').body)
      end
    end
  end
end

