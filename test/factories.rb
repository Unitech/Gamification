
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

Factory.define :mission do |m|
  m.title Faker::Lorem.sentence
  m.euros rand(500)
  m.points rand(500)
  m.epices rand(500)
  m.resume Faker::Lorem.paragraph
  m.description Faker::Lorem.paragraphs(6)
  m.begin_date time_rand(Time.now, 2.days.from_now)
  m.end_date time_rand(Time.now, 10.days.from_now)
  m.state rand(2)
  m.category rand(5)
end

Factory.define :user do |u|
  u.f_name Faker::Name.first_name
  u.l_name Faker::Name.last_name
  u.username Faker::Name.name
  u.email Faker::Internet.email
  u.password '123456'
end
