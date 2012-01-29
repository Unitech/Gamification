require "test_helper"

class ClassMethodsTest < ActiveSupport::TestCase

  test "model_fields is an ActiveSupport::OrderedHash" do
    assert TypusUser.model_fields.instance_of?(ActiveSupport::OrderedHash)
  end

  test "model_fields for TypusUser" do
    expected = [[:id, :integer],
                [:first_name, :string],
                [:last_name, :string],
                [:role, :string],
                [:email, :string],
                [:status, :boolean],
                [:token, :string],
                [:salt, :string],
                [:crypted_password, :string],
                [:preferences, :string],
                [:created_at, :datetime],
                [:updated_at, :datetime]]

    assert_equal expected.map(&:first), TypusUser.model_fields.keys
    assert_equal expected.map(&:last), TypusUser.model_fields.values
  end

  test "model_fields for Post" do
    expected = [[:id, :integer],
                [:title, :string],
                [:body, :text],
                [:status, :string],
                [:favorite_comment_id, :integer],
                [:published_at, :datetime],
                [:typus_user_id, :integer],
                [:published, :boolean],
                [:created_at, :datetime],
                [:updated_at, :datetime],
                [:numeric_status, :integer]]

    assert_equal expected.map(&:first), Post.model_fields.keys
    assert_equal expected.map(&:last), Post.model_fields.values
  end

  test "model_relationships is an ActiveSupport::OrderedHash" do
    assert TypusUser.model_relationships.instance_of?(ActiveSupport::OrderedHash)
  end

  test "model_relationships for Post" do
    expected = [[:comments, :has_many],
                [:categories, :has_and_belongs_to_many],
                [:user, nil]]
    expected.each do |key, value|
      assert_equal value, Post.model_relationships[key]
    end
  end

  test "typus_description returns the description of a model" do
    assert_equal "System Users Administration", TypusUser.typus_description
  end

  test "typus_fields_for accepts strings" do
    assert_equal %w(email role status), TypusUser.typus_fields_for("list").keys
  end

  test "typus_fields_for accepts symbols" do
    assert_equal %w(email role status), TypusUser.typus_fields_for(:list).keys
  end

  test "typus_fields_for returns list fields for TypusUser" do
    expected = [["email", :string],
                ["role", :selector],
                ["status", :boolean]]

    assert_equal expected.map(&:first), TypusUser.typus_fields_for(:list).keys
    assert_equal expected.map(&:last), TypusUser.typus_fields_for(:list).values
  end

  test "typus_fields_for returns form fields for TypusUser" do
    expected = [["first_name", :string],
                ["last_name", :string],
                ["role", :selector],
                ["email", :string],
                ["password", :password],
                ["password_confirmation", :password],
                ["locale", :selector],
                ["status", :boolean]]

    assert_equal expected.map(&:first), TypusUser.typus_fields_for(:new).keys
    assert_equal expected.map(&:last), TypusUser.typus_fields_for(:form).values
  end

  test "typus_fields_for returns form fields for Asset" do
    expected = [["caption", :string],
                ["dragonfly", :dragonfly],
                ["dragonfly_required", :dragonfly]]

    assert_equal expected.map(&:first), Asset.typus_fields_for(:special).keys
    assert_equal expected.map(&:last), Asset.typus_fields_for(:special).values
  end

  test "typus_fields_for with virtual attributes" do
    expected = [["caption", :string],
                ["original_file_name", :virtual]]

    assert_equal expected.map(&:first), Asset.typus_fields_for(:virtual).keys
    assert_equal expected.map(&:last), Asset.typus_fields_for(:virtual).values
  end

  test "typus_fields_for raises a RuntimeError when model does not have configuration" do
    assert_raises RuntimeError do
      Class.new(ActiveRecord::Base).typus_fields_for(:form)
    end
  end

  test "typus_fields_for returns relationship fields for TypusUser" do
    expected = %w(first_name last_name role email locale)
    assert_equal expected, TypusUser.typus_fields_for(:relationship).keys
  end

  test "typus_fields_for returns undefined fields for TypusUser" do
    expected = %w(first_name last_name role email locale)
    assert_equal expected, TypusUser.typus_fields_for(:undefined).keys
  end

  test "typus_fields_for returns fields for new Asset" do
    expected = %w(dragonfly dragonfly_required paperclip paperclip_required)
    assert_equal expected, Asset.typus_fields_for(:new).keys
  end

  test "typus_fields_for returns fields for edit Asset" do
    expected = %w(caption dragonfly dragonfly_required paperclip paperclip_required)
    assert_equal expected, Asset.typus_fields_for(:edit).keys
  end

  test "typus_fields_for works for transversal fields" do
    expected = [["email", :string],
                ["post", :belongs_to],
                ["post_id", :integer],
                ["spam", :boolean],
                ["post.title", :transversal]]

    assert_equal expected.map(&:first), Comment.typus_fields_for(:list).keys
    assert_equal expected.map(&:last), Comment.typus_fields_for(:list).values
  end

  test "typus_fields_for for EntryDefault which does not have field values on index" do
    expected = [["id", :integer]]
    assert_equal expected.map(&:first), EntryDefault.typus_fields_for(:index).keys
    assert_equal expected.map(&:last), EntryDefault.typus_fields_for(:index).values
  end

  test "typus_fields_for for EntryDefault which does not have field values on other actions" do
    expected = [["id", :integer],
                ["title", :string],
                ["content", :text],
                ["type", :string],
                ["published", :boolean],
                ["deleted_at", :datetime]]

    assert_equal expected.map(&:first), EntryDefault.typus_fields_for(:new).keys
    assert_equal expected.map(&:last), EntryDefault.typus_fields_for(:new).values
  end

  test "typus_filters for TypusUser" do
    expected = [["status", :boolean],
                ["role", :string]]

    assert_equal expected.map(&:first).join(", "), Typus::Configuration.config["TypusUser"]["filters"]
    assert_equal expected.map(&:first), TypusUser.typus_filters.keys
    assert_equal expected.map(&:last), TypusUser.typus_filters.values
  end

  test "typus_filters for Post" do
    expected = [["status", :string],
                ["numeric_status", :integer],
                ["created_at", :datetime]]

    assert_equal expected.map(&:first).join(", "), Typus::Configuration.config["Post"]["filters"]
    assert_equal expected.map(&:first), Post.typus_filters.keys
    assert_equal expected.map(&:last), Post.typus_filters.values
  end

  test "typus_filters for Case" do
    assert Case.typus_filters.empty?
  end

  test "get_typus_filters for Case" do
    assert Case.get_typus_filters.empty?
  end

  test "get_typus_filters for Post" do
    assert_equal [:status, :numeric_status, :created_at], Post.get_typus_filters
  end

  test "typus_actions_on accepts strings and symbols" do
    assert_equal %w(cleanup), Post.typus_actions_on("index")
    assert_equal %w(cleanup), Post.typus_actions_on(:index)
  end

  test "typus_actions_on returns actions for our models" do
    assert TypusUser.typus_actions_on(:list).empty?
    assert_equal %w(send_as_newsletter preview), Post.typus_actions_on(:edit)
  end

  test "typus_options_for accepts strings and symbols" do
    assert Post.typus_options_for("form_rows").eql?(15)
    assert Post.typus_options_for(:form_rows).eql?(15)
  end

  test "typus_options_for returns nil when options do not exist" do
    assert_nil TypusUser.typus_options_for(:unexisting)
  end

  test "typus_options_for returns options for models" do
    assert Post.typus_options_for(:form_rows).eql?(15)
    assert Page.typus_options_for(:form_rows).eql?(25)
  end

  test "typus_options_for returns sortable options as a boolean" do
    assert Post.typus_options_for(:sortable)
    assert !Page.typus_options_for(:sortable)
  end

  test "typus_application" do
    assert_equal "CRUD", Entry.typus_application
    assert_equal "CRUD Extended", Post.typus_application
    assert_equal "Unknown", View.typus_application
  end

  test "typus_field_options_for" do
    assert_equal [:status, :numeric_status], Post.typus_field_options_for(:selectors)
    assert Post.typus_field_options_for(:unexisting).empty?
  end

  test "typus_boolean accepts string and symbols" do
    expected = [["Active", "true"], ["Inactive", "false"]]
    assert_equal expected, TypusUser.typus_boolean("status")
    assert_equal expected, TypusUser.typus_boolean(:status)
  end

  test "typus_boolean returns custom keys" do
    expected = [["True", "true"], ["False", "false"]]
    assert_equal expected, Post.typus_boolean(:status)
    expected = [["Yes, it's spam", "true"], ["No, it's not spam", "false"]]
    assert_equal expected, Comment.typus_boolean(:spam)
  end

  test "typus_date_format accepts string and symbols" do
    assert_equal :default, Post.typus_date_format("unknown")
    assert_equal :default, Post.typus_date_format(:unknown)
  end

  test "typus_date_format returns date_format for Post" do
    assert_equal :default, Post.typus_date_format
    assert_equal :short, Post.typus_date_format(:created_at)
  end

  test "typus_template accepts strings and symbols" do
    assert_equal "datepicker", Post.typus_template("published_at")
    assert_equal "datepicker", Post.typus_template(:published_at)
  end

  test "typus_template returns nil if template does not exist" do
    assert_nil Post.typus_template(:created_at)
  end

  test "typus_defaults_for accepts string and symbols" do
    assert_equal %w(title), Post.typus_defaults_for("search")
    assert_equal %w(title), Post.typus_defaults_for(:search)
  end

  test "typus_defaults_for returns default_for relationships on Post" do
    assert_equal %w(categories comments views), Post.typus_defaults_for(:relationships)
  end

  test "typus_search_fields returns a hash with the search modifiers" do
    search = ["=id", "^title", "body"]
    Post.stubs(:typus_defaults_for).with(:search).returns(search)
    expected = {"body"=>"@", "title"=>"^", "id"=>"="}
    assert_equal expected, Post.typus_search_fields
  end

  test "typus_search_fields returns and empty hash" do
    Post.stubs(:typus_defaults_for).with(:search).returns([])
    assert Post.typus_search_fields.empty?
  end

  # I expect ARel to take care of table names when building queries.
  test "typus_order_by returns defaults_for order_by on Post" do
    # assert_equal "posts.title ASC, posts.created_at DESC", Post.typus_order_by
    assert_equal "title ASC, created_at DESC", Post.typus_order_by
    assert_equal %w(title -created_at), Post.typus_defaults_for(:order_by)
  end

  test "typus_user_id exists on post" do
    assert Post.typus_user_id?
  end

  test "typus_user_id does not exist on TypusUser" do
    assert !TypusUser.typus_user_id?
  end

  test "read_model_config returns data for existing model" do
    expected = {"application"=>"CRUD Extended",
                "fields"=>{"default"=>"caption, dragonfly, dragonfly_required",
                           "special"=>"caption, dragonfly, dragonfly_required",
                           "form"=>"caption, dragonfly, dragonfly_required, paperclip, paperclip_required",
                           "new"=>"dragonfly, dragonfly_required, paperclip, paperclip_required",
                           "virtual"=>"caption, original_file_name"}}
    assert_equal expected, Asset.read_model_config
  end

  test "read_model_config raises an error when model does not exist on configuration" do
    assert_raises RuntimeError do
      Article.read_model_config
    end
  end

end
