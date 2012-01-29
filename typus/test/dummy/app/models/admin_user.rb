##
# Here we test the new version of Typus Authenticated users. This is stuff
# will change so you might prefer using the other mixin.
#
class AdminUser < ActiveRecord::Base
  has_admin
end
