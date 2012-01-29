module Typus
  module Generators
    class InitializersGenerator < Rails::Generators::Base

      source_root File.expand_path("../../templates", __FILE__)

      desc <<-MSG
Description:
  Copies Typus initializers into your application.

      MSG

      def generate_initializers
        template "config/initializers/typus.rb", "config/initializers/typus.rb"
        template "config/initializers/typus_resources.rb", "config/initializers/typus_resources.rb"
      end

    end
  end
end
