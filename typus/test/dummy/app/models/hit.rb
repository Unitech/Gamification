class Hit

  if defined?(Mongoid)
    include Mongoid::Document

    field :name, :type => String
    field :description, :type => String

    validates_presence_of :name
    validates_uniqueness_of :name
  else
    extend ActiveModel::Naming
  end

end
