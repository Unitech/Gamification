# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

missions = []

7.times do 
  missone = Mission.new(:title => Faker::Lorem.sentence,
                        :euros => rand(500),
                        :points => rand(500),
                        :epices => rand(50),
                        :resume => Faker::Lorem.paragraph,
                        :description => Faker::Lorem.paragraphs(6),
                        :begin_date => time_rand(Time.now, 2.days.from_now),
                        :end_date => time_rand(Time.now, 10.days.from_now),
                        :state => rand(2),
                        :category => rand(5),
                        :image => File.open(File.join(Rails.root, '/db/seed_sample/' + (rand(3) + 1).to_s + '.jpg')))
  missone.save
  missions << missone
end

users = []

5.times do 
  users << User.create(:f_name => Faker::Name.first_name,
                      :l_name => Faker::Name.last_name, 
                      :username => Faker::Name.name,
                      :email => Faker::Internet.email,
                      :password => '123456')
end


missions.each do |m|
  5.times do
    Comment.create(:content => Faker::Lorem.paragraph,
                   :user_id => users[rand(users.length)].id,
                   :mission_id => missions[rand(missions.length)].id)
  end
end
