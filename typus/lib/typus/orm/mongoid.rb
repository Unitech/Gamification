begin
  require 'mongoid'
rescue LoadError
end

if defined?(Mongoid)
  require 'typus/orm/mongoid/class_methods'
  Mongoid::Document::ClassMethods.send(:include, Typus::Orm::Mongoid::ClassMethods)

  require 'typus/orm/mongoid/instance_methods'
  Mongoid::Document.send(:include, Typus::Orm::Mongoid::InstanceMethods)

  require 'typus/orm/mongoid/search'
  Mongoid::Document::ClassMethods.send(:include, Typus::Orm::Mongoid::Search)
end
