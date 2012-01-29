module Typus
  module Orm
    module Mongoid
      module Search

        include Typus::Orm::Base::Search

        def build_search_conditions(key, value)
          search_fields = typus_search_fields
          search_fields = search_fields.empty? ? { "name" => "@" } : search_fields

          search_query = search_fields.map do |key, type|
            related_model = self

            split_keys = key.split('.')
            split_keys[0..-2].each do |split_key|
              if related_model.responds_to? :relations && related_model.relations[split_key] && related_model.relations[split_key].embeded?
                related_model = related_model.relations[split_key]
              else
                raise "Search key '#{key}' is invalid. #{split_key} is not an embeded document" if related_model.embeded?
              end
            end

            field = related_model.fields[split_keys.last]
            raise "Search key '#{field.name}' is invalid." unless field
            value = field.serialize(value) if field.type.ancestors.include?(Numeric)

            {key => value}
          end

          {'$or' => search_query}
        end

        def build_filter_interval(interval, key)
          {key.to_sym.gt => interval.first, key.to_sym.lt => interval.last}
        end

        # TODO: Detect the primary_key for this object.
        def build_has_many_conditions(key, value)
          ["#{key}.id = ?", value]
        end

      end
    end
  end
end
