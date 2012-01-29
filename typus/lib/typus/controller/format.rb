require 'csv'

module Typus
  module Controller
    module Format

      protected

      def get_paginated_data
        items_per_page = @resource.typus_options_for(:per_page)
        @items = @resource.page(params[:page]).per(items_per_page)
      end

      alias_method :generate_html, :get_paginated_data

      #--
      # TODO: Find in batches only works properly if it's used on models, not
      #       controllers, so in this action does nothing. We should find a way
      #       to be able to process large amounts of data.
      #++
      def generate_csv
        if can_export?(:csv)
          fields = @resource.typus_fields_for(:csv)

          filename = Rails.root.join("tmp", "export-#{@resource.to_resource}-#{Time.zone.now.to_s(:number)}.csv")

          options = { :conditions => @conditions, :batch_size => 1000 }

          ::CSV.open(filename, 'w') do |csv|
            csv << fields.keys.map { |k| @resource.human_attribute_name(k) }
            @resource.find_in_batches(options) do |records|
              records.each do |record|
                csv << fields.map do |key, value|
                         case value
                         when :transversal
                           a, b = key.split(".")
                           record.send(a).send(b)
                         when :belongs_to
                           record.send(key).try(:to_label)
                         else
                           record.send(key)
                         end
                       end
              end
            end
          end

          send_file filename
        else
          not_allowed
        end
      end

      def generate_json
        export(:json)
      end

      def generate_xml
        can_export?(:xml) ? export(:xml) : not_allowed
      end

      def export(format)
        fields = @resource.typus_fields_for(format).map(&:first)
        methods = fields - @resource.column_names
        except = @resource.column_names - fields

        get_paginated_data

        render format => @items.send("to_#{format}", :methods => methods, :except => except)
      end

      def can_export?(format)
        @resource.typus_options_for(:export).extract_settings.include?(format.to_s)
      end

    end
  end
end
