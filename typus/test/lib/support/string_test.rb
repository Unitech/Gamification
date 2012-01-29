require "test_helper"

class StringTest < ActiveSupport::TestCase

  test "extract_settings" do
    expected = %w(a b c)
    assert "a, b, c".extract_settings.eql?(expected)
    assert " a  , b,  c ".extract_settings.eql?(expected)
  end

  test "remove_prefix returns strings without prefixes" do
    assert_equal "posts", "admin/posts".remove_prefix
    assert_equal "typus_users", "admin/typus_users".remove_prefix
    assert_equal "delayed/jobs", "admin/delayed/jobs".remove_prefix
    assert_equal "posts", "typus/posts".remove_prefix
    assert_equal "typus_users", "typus/typus_users".remove_prefix
    assert_equal "delayed/tasks", "typus/delayed/tasks".remove_prefix
  end

=begin
  test "extract_class" do
    class SucursalBancaria; end

    Typus::Configuration.models_constantized = { "Post" => Post,
                                                 "TypusUser" => TypusUser,
                                                 "Delayed::Task" => Delayed::Task,
                                                 "SucursalBancaria" => SucursalBancaria }

    assert_equal Post, "admin/posts".extract_class
    assert_equal TypusUser, "admin/typus_users".extract_class
    assert_equal Delayed::Task, "admin/delayed/tasks".extract_class
    assert_equal SucursalBancaria, "admin/sucursales_bancarias".extract_class
  end
=end

  test "acl_action_mapper returns create" do
    assert_equal "create", "new".acl_action_mapper
    assert_equal "create", "create".acl_action_mapper
  end

  test "acl_action_mapper returns read" do
    assert_equal "read", "index".acl_action_mapper
    assert_equal "read", "show".acl_action_mapper
  end

  test "acl_action_mapper returns update" do
    %w(edit update position toggle relate unrelate).each do |action|
      assert_equal "update", action.acl_action_mapper
    end
  end

  test "acl_action_mapper returns delete" do
    assert_equal "delete", "destroy".acl_action_mapper
    assert_equal "delete", "trash".acl_action_mapper
  end

  test "acl_action_mapper returns other" do
    assert_equal "other", "other".acl_action_mapper
  end

  test "to_resource converts String into resource" do
    assert_equal "entries", "Entry".to_resource
    assert_equal "category/entries", "Category::Entry".to_resource
  end

end
