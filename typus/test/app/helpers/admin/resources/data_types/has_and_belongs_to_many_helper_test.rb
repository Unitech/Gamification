require "test_helper"

class Admin::Resources::DataTypes::HasAndBelongsToManyHelperTest < ActiveSupport::TestCase

  include Admin::Resources::DataTypes::HasAndBelongsToManyHelper
  include Admin::Resources::FormHelper

  def render(*args); args; end

  setup do
  end

  test "typus_has_and_belongs_to_many_field" do
    @resource, attribute, form = EntryDefault, 'categories', {}
    categories = FactoryGirl.create_list(:category, 5)
    @item = FactoryGirl.create(:entry)
    @item.categories << categories.first

    template, options = typus_has_and_belongs_to_many_field(attribute, form)

    # Template
    assert_equal "admin/templates/has_and_belongs_to_many", template

    # Options
    assert_equal attribute, options[:attribute]
    assert_equal "entry_default_categories", options[:attribute_id]
    assert_equal "entry_default[category_ids][]", options[:related_ids]
    assert_equal "Categories", options[:label_text]
    assert_equal Category, options[:values]
    assert_equal @item.categories, options[:related_items]
  end

  test "build_label_text_for_has_and_belongs_to_many when disabled" do
    expected = "Read only"
    output = build_label_text_for_has_and_belongs_to_many(Entry, { :disabled => true })
    assert_equal expected, output
  end

  # OPTIMIZE: This method should not be redefined here!
  def admin_user
    FactoryGirl.create(:typus_user)
  end

  # OPTIMIZE: This method should not be redefined here!
  def current_role
    admin_user.role.to_sym
  end

  # OPTIMIZE: This method should not be redefined here!
  def headless_mode?
    true
  end

end
