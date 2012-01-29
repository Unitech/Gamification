module Typus
  module Resources

    ##
    # Setup Typus::Resources:
    #
    #     Typus::Resources.setup do |config|
    #       config.default_action_on_item = "index"
    #     end
    #
    def self.setup
      yield self
    end

    mattr_accessor :default_action_on_item
    @@default_action_on_item = "edit"

    mattr_accessor :end_year
    @@end_year = nil

    mattr_accessor :form_rows
    @@form_rows = 15

    mattr_accessor :minute_step
    @@minute_step = nil

    mattr_accessor :only_user_items
    @@only_user_items = false

    mattr_accessor :per_page
    @@per_page = 25

    mattr_accessor :sortable
    @@sortable = true

    mattr_accessor :start_year
    @@start_year = nil

    mattr_accessor :hide_from_sidebar
    @@hide_from_sidebar = false

    mattr_accessor :hide_from_dashboard
    @@hide_from_dashboard = false

    mattr_accessor :export
    @@export = ""

    def self.method_missing(*args)
      nil
    end

  end
end
