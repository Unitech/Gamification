# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

##
# Setup an initial site ...
##

FactoryGirl.create(:site, :domain => "localhost")

##
# CRUD
##

FactoryGirl.create_list(:entry, 30)

##
# CRUD Extended
##

FactoryGirl.create_list(:category, 5)
FactoryGirl.create_list(:post, 5)

assets_path = "#{Rails.root}/db/seeds/assets"
5.times { |i| FactoryGirl.create(:asset,
                                 :dragonfly => File.new("#{assets_path}/00#{i}.jpg"),
                                 :dragonfly_required => File.new("#{assets_path}/00#{i}.jpg"),
                                 :paperclip => File.new("#{assets_path}/00#{i}.jpg")) }

##
# HasManyThrough
##

5.times do
  project = FactoryGirl.create(:project)
  5.times { project.collaborators << FactoryGirl.create(:user) }
end

##
# HasOne
##

FactoryGirl.create_list(:invoice, 5)

##
# Polymorphic
##

FactoryGirl.create_list(:bird, 5)
FactoryGirl.create_list(:dog, 5)
