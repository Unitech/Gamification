module Typus
  module Orm
    module Mongoid
      module InstanceMethods

        def update_attributes(attributes, options ={})
          super(attributes)
        end

        def toggle(attribute)
          self[attribute] = !send("#{attribute}?")
          self
        end

      end
    end
  end
end
