module Typus
  module Orm
    module ActiveRecord
      module Search

        include Typus::Orm::Base::Search

        def build_search_conditions(key, value)
          Array.new.tap do |search|
            query = ::ActiveRecord::Base.connection.quote_string(value.downcase)

            search_fields = typus_search_fields
            search_fields = search_fields.empty? ? { "name" => "@" } : search_fields

            search_fields.each do |key, value|
              _query = case value
                       when "=" then query
                       when "^" then "#{query}%"
                       when "@" then "%#{query}%"
                       end

              column_name = (key.match('\.') ? key : "#{table_name}.#{key}")
              table_key = (adapter == 'postgresql') ? "LOWER(TEXT(#{column_name}))" : "#{column_name}"

              search << "#{table_key} LIKE '#{_query}'"
            end
          end.join(" OR ")
        end

        def build_filter_interval(interval, key)
          ["#{table_name}.#{key} BETWEEN ? AND ?", interval.first.to_s(:db), interval.last.to_s(:db)]
        end

        def build_my_joins(params)
          query_params = params.dup
          query_params.reject! { |k, v| !model_relationships.keys.include?(k.to_sym) }
          query_params.compact.map { |k, v| k.to_sym }
        end

      end
    end
  end
end
