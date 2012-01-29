# -*- encoding: utf-8 -*-

module Typus
  module I18n

    class << self

      ##
      # Instead of having to translate strings and defining a default value:
      #
      #     Typus::I18n.t("Hello World!", :default => 'Hello World!')
      #
      # We define this method to define the value only once:
      #
      #     Typus::I18n.t("Hello World!")
      #
      # Note that interpolation still works:
      #
      #     Typus::I18n.t("Hello %{world}!", :world => @world)
      #
      def t(key, options = {})
        options[:default] ||= key
        ::I18n.t(key, options)
      end

      def default_locale
        :en
      end

      def available_locales
        { "Brazilian Portuguese" => "pt-BR",
          "Català" => "ca",
          "German" => "de",
          "Greek"  => "el",
          "Italiano" => "it",
          "English" => "en",
          "Español" => "es",
          "Français" => "fr",
          "Magyar" => "hu",
          "Portuguese" => "pt-PT",
          "Russian" => "ru",
          "中文" => "zh-CN" }
      end

    end

  end
end
