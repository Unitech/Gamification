module Typus
  module Orm
    module Base
      module ClassMethods

        # Model fields as an <tt>ActiveSupport::OrderedHash</tt>.
        def model_fields; end

        # Model relationships as an <tt>ActiveSupport::OrderedHash</tt>.
        def model_relationships; end

        # Model description for admin panel.
        def typus_description
          read_model_config['description']
        end

        # Form and list fields
        def typus_fields_for(filter); end

        def typus_filters; end

        # Extended actions for this model on Typus.
        def typus_actions_on(filter)
          actions = read_model_config['actions']
          actions && actions[filter.to_s] ? actions[filter.to_s].extract_settings : []
        end

        # Used for +search+, +relationships+
        def typus_defaults_for(filter)
          read_model_config[filter.to_s].try(:extract_settings) || []
        end

        def typus_search_fields
          Hash.new.tap do |search|
            typus_defaults_for(:search).each do |field|
              if field.starts_with?("=")
                field.slice!(0)
                search[field] = "="
              elsif field.starts_with?("^")
                field.slice!(0)
                search[field] = "^"
              else
                search[field] = "@"
              end
            end
          end
        end

        def typus_application
          name = read_model_config['application'] || 'Unknown'
          name.extract_settings.first
        end

        def typus_field_options_for(filter)
          options = read_model_config['fields']['options']
          options && options[filter.to_s] ? options[filter.to_s].extract_settings.map(&:to_sym) : []
        end

        #--
        # With +Typus::Resources.setup+ we can define application defaults.
        #
        #     Typus::Resources.setup do |config|
        #       config.per_page = 25
        #     end
        #
        # If for any reason we need a better default for an specific resource we
        # can override it on +application.yaml+.
        #
        #     Post:
        #       ...
        #       options:
        #         per_page: 25
        #++
        def typus_options_for(filter)
          options = read_model_config['options']

          unless options.nil? || options[filter.to_s].nil?
            options[filter.to_s]
          else
            Typus::Resources.send(filter)
          end
        end

        def typus_order_by
          typus_defaults_for(:order_by).map do |field|
            field.include?('-') ? "#{field.delete('-')} DESC" : "#{field} ASC"
          end.join(', ')
        end

        #--
        # Define our own boolean mappings.
        #
        #     Post:
        #       fields:
        #         default: title, status
        #         options:
        #           booleans:
        #             status: "Published", "Not published"
        #
        #++
        def typus_boolean(attribute = :default)
          options = read_model_config['fields']['options']

          boolean = if options && options['booleans'] && boolean = options['booleans'][attribute.to_s]
            boolean.is_a?(String) ? boolean.extract_settings : boolean
          else
            ["True", "False"]
          end

          [[boolean.first, "true"], [boolean.last, "false"]]
        end

        #--
        # Custom date formats.
        #++
        def typus_date_format(attribute = :default)
          options = read_model_config['fields']['options']
          if options && options['date_formats'] && options['date_formats'][attribute.to_s]
            options['date_formats'][attribute.to_s].to_sym
          else
            :default
          end
        end

        #--
        # This is user to use custome templates for attribute:
        #
        #     Post:
        #       fields:
        #         form: title, body, status
        #         options:
        #           templates:
        #             body: rich_text
        #
        # Templates are stored on <tt>app/views/admin/templates</tt>.
        #++
        def typus_template(attribute)
          options = read_model_config['fields']['options']
          if options && options['templates'] && options['templates'][attribute.to_s]
            options['templates'][attribute.to_s]
          end
        end

        def adapter
          @adapter ||= ::ActiveRecord::Base.configurations[Rails.env]['adapter']
        end

        def typus_user_id?; end

        def read_model_config
          Typus::Configuration.config[name] or raise "No typus configuration specified for #{name}"
        end

        #--
        #     >> Post.to_resource
        #     => "posts"
        #     >> Admin::User.to_resource
        #     => "admin/users"
        #++
        def to_resource
          name.underscore.pluralize
        end

        def custom_attribute?(field)
          case field.to_s
          when 'parent', 'parent_id' then :tree
          when /password/            then :password
          when 'position'            then :position
          when /\./                  then :transversal
          end
        end

        def virtual_fields
          instance_methods.map(&:to_s) - model_fields.keys.map(&:to_s)
        end

      end
    end
  end
end
