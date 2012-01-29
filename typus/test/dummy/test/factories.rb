##
# Auth
##

FactoryGirl.define do
  factory :admin_user do
    sequence(:email) { |n| "admin+#{n}@example.com" }
    password "XXXXXXXX"
    role "admin"
  end

  factory :devise_user do
    sequence(:email) { |n| "john+#{n}@example.com"}
    password "12345678"
  end

  factory :typus_user do
    sequence(:email) { |n| "user+#{n}@example.com" }
    role "admin"
    status true
    token "1A2B3C4D5E6F"
    password "12345678"
  end
end

##
# CRUD
##

FactoryGirl.define do
  factory :entry do
    sequence(:title) { |n| "Entry##{n}" }
    content "Body of the entry"
  end

  factory :entry_bulk do
    sequence(:title) { |n| "EntryBulk##{n}" }
    content "Body of the entry"
  end

  factory :entry_trash do
    sequence(:title) { |n| "EntryTrash##{n}" }
    content "Body of the entry"
  end

  factory :case do
    sequence(:title) { |n| "Case##{n}" }
    content "Body of the entry"
  end
end

##
# CRUD Extended
##

FactoryGirl.define do
  factory :asset do
    sequence(:caption) { |n| "Asset##{n}" }
    dragonfly File.new("#{Rails.root}/public/images/rails.png")
    dragonfly_required File.new("#{Rails.root}/public/images/rails.png")
    paperclip File.new("#{Rails.root}/public/images/rails.png")
    paperclip_required File.new("#{Rails.root}/public/images/rails.png")
  end

  factory :category do
    sequence(:name) { |n| "Category##{n}" }
  end

  factory :comment do
    sequence(:name) { |n| "Comment##{n}" }
    sequence(:email) { |n| "john+#{n}@example.com" }
    body "Body of the comment"
    association :post
  end

  factory :page do
    sequence(:title) { |n| "Page##{n}" }
    body "Content"
  end

  factory :post do
    sequence(:title) { |n| "Post##{n}" }
    body "Body"
    status "published"
  end

  factory :view do
    ip "127.0.0.1"
    association :post
    association :site
  end
end

##
# HasOne Association
#

FactoryGirl.define do
  factory :invoice do
    sequence(:number) { |n| "Invoice##{n}" }
    association :order
  end

  factory :order do
    sequence(:number) { |n| "Order##{n}" }
  end
end

##
# HasManyThrough Association
#

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User##{n}" }
    sequence(:email) { |n| "user.#{n}@example.com" }
    role "admin"
    token "qw1rd3-1w3f5b"
  end

  factory :project do
    sequence(:name) { |n| "Project##{n}" }
    association :user
  end

  factory :project_collaborators do
    association :user
    association :project
  end
end

##
# Polymorphic
##

FactoryGirl.define do
  factory :animal do
    sequence(:name) { |n| "Animal##{n}" }
  end

  factory :bird do
    sequence(:name) { |n| "Bird##{n}" }
  end

  factory :dog do
    sequence(:name) { |n| "Dog##{n}" }
  end

  factory :image_holder do
    sequence(:name) { |n| "ImageHolder##{n}" }
  end
end

##
# Contexts
##

FactoryGirl.define do
  factory :site do
    sequence(:name) { |n| "Site##{n}" }
    sequence(:domain) { |n| "site#{n}.local" }
  end
end
