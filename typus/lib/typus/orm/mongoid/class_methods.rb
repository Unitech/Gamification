module Typus
  module Orm
    module Mongoid
      module ClassMethods

        include Typus::Orm::Base::ClassMethods

        delegate :any?, :to => :all

        def table_name
          collection_name
        end

        def typus_order_by(order_field = nil, sort_order = nil)
          if order_field.nil? || sort_order.nil?
            order_array = typus_defaults_for(:order_by).map do |field|
              field.include?('-') ? [field.delete('-'), :desc] : [field, :asc]
            end
          else
            order_array = [[order_field, sort_order.downcase.to_sym]]
          end
          self.order_by(order_array)
        end

        # For the moment return model fields.
        def typus_fields_for(filter)
          model_fields
        end

        def virtual_attribute?(field)
          :virtual if virtual_fields.include?(field.to_s)
        end

        def selector_attribute?(field)
          :selector if typus_field_options_for(:selectors).include?(field)
        end

        def association_attribute?(field)
          reflect_on_association(field).macro if reflect_on_association(field)
        end

        #
        # Model fields as an <tt>ActiveSupport::OrderedHash</tt>.
        def model_fields
          hash = ActiveSupport::OrderedHash.new

          fields.each do |key, value|
            hash[key.to_sym] = value.options[:type].to_s.downcase.to_sym
          end

          rejections = [:_id, :_type]
          hash.reject { |k, v| rejections.include?(k) }
        end

        # Model relationships as an <tt>ActiveSupport::OrderedHash</tt>.
        def model_relationships
          ActiveSupport::OrderedHash.new.tap do |hash|
            relations.values.map { |i| hash[i.name] = i.macro }
          end
        end

        def typus_user_id?
          fields.keys.include?(Typus.user_foreign_key)
        end

      end
    end
  end
end
