module Typus
  module Generators
    class ConfigGenerator < Rails::Generators::Base

      source_root File.expand_path("../../templates", __FILE__)

      desc <<-MSG
Description:
  Creates configuration files.

      MSG

      def generate_config
        copy_file "config/typus/README"
        generate_yaml.each do |key, value|
          if (@configuration = value)[:base].present?
            template "config/typus/application.yml", "config/typus/#{key}.yml"
            template "config/typus/application_roles.yml", "config/typus/#{key}_roles.yml"
          end
        end
      end

      protected

      def configuration
        @configuration
      end

      def fields_for(model, *defaults)
        rejections = %w( ^id$ _type$ type created_at created_on updated_at updated_on deleted_at ).join("|")
        fields = ActiveRecord::Base.connected? && model.table_exists? ? model.columns.map(&:name) : defaults
        fields.reject { |f| f.match(rejections) }.join(", ")
      end

      def generate_yaml
        Typus.reload!

        configuration = {}
        models = Typus.application_models.reject { |m| Typus.models.include?(m) }.map(&:constantize)

        models.each do |model|
          key = model.name.underscore

          configuration[key] = {}

          relationships = [ :has_many, :has_one ].map do |relationship|
                            model.reflect_on_all_associations(relationship).map { |i| i.name.to_s }
                          end.flatten.join(", ")

          configuration[key][:base] = <<-RAW
#{model}:
  fields:
    default: #{fields_for(model, 'to_label')}
    form: #{fields_for(model)}
  relationships: #{relationships}
  application: Application
          RAW

          configuration[key][:roles] = "#{model}: create, read, update, delete"
        end

        configuration
      end

    end
  end
end
