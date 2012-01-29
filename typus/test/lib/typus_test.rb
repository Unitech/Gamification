require "test_helper"

class TypusTest < ActiveSupport::TestCase

  test "default_config for admin_title" do
    assert Typus.admin_title.eql?('Typus')
  end

  test "default_config for admin_sub_title" do
    assert Typus.admin_sub_title.is_a?(String)
  end

  test "default_config for authentication" do
    assert Typus.authentication.eql?(:session)
  end

  test "default_config for mailer_sender" do
    assert Typus.mailer_sender.nil?
  end

  test "default_config for username" do
    assert Typus.username.eql?('admin')
  end

  test "default_config for subdomain" do
    assert Typus.subdomain.nil?
  end

  test "default_config for password" do
    assert Typus.password.eql?('columbia')
  end

  test "default_config for file_preview and file_thumbnail (paperclip)" do
    assert Typus.file_preview.eql?(:medium)
    assert Typus.file_thumbnail.eql?(:thumb)
  end

  test "default_config for image_preview_size and image_thumb_size (dragonfly)" do
    assert_equal "x650>", Typus.image_preview_size
    assert_equal "x100", Typus.image_thumb_size
  end

  test "default_config for relationship" do
    assert Typus.relationship.eql?('typus_users')
  end

  test "default_config for master_role" do
    assert Typus.master_role.eql?('admin')
  end

  test "root is a Pathname" do
    assert Typus.root.is_a?(Pathname)
  end

  test "config_folder is an String" do
    assert Typus.config_folder.is_a?(String)
  end

=begin
  # TODO: Decide if we want this test ...
  test "applications returns applications sorted" do
    expected = ["Admin",
                "CRUD",
                "CRUD Extended",
                "Extensions",
                "HasMany",
                "HasOne",
                "MongoDB",
                "Polymorphic"]

    assert_equal "CRUD", Typus.applications.first
    expected.each { |e| assert Typus.applications.include?(e) }
  end
=end

=begin
  # TODO: Decide if we want this test ...
  test "application returns modules of the CRUD Extended application" do
    # OPTIMIZE: There's no need to sort stuff but this is required to make it
    #           work with Ruby 1.8.7.
    expected = %w(Asset Case Comment Page Post Article::Entry ReadOnlyEntry EntryDefault).sort
    assert_equal expected, Typus.application("CRUD Extended").sort
  end
=end

  test "models are sorted" do
    expected = ["AdminUser",
                "Animal",
                "Article::Entry",
                "Asset",
                "Bird",
                "Case",
                "Category",
                "Comment",
                "DeviseUser",
                "Dog",
                "Entry",
                "EntryBulk",
                "EntryDefault",
                "EntryTrash",
                "Hit",
                "ImageHolder",
                "Invoice",
                "Order",
                "Page",
                "Post",
                "Project",
                "ProjectCollaborator",
                "ReadOnlyEntry",
                "Task",
                "TypusUser",
                "User",
                "View"]
    assert_equal expected, Typus.models
  end

  test "resources class_method" do
    assert_equal %w(Git Status WatchDog), Typus.resources
  end

  test "user_class returns default value" do
    assert_equal TypusUser, Typus.user_class
  end

  test "user_class_name returns default value" do
    assert Typus.user_class_name.eql?("TypusUser")
  end

  test "user_class_name setter presence" do
    assert Typus.respond_to?("user_class_name=")
  end

  test "user_foreign_key returns default value" do
    assert_equal "typus_user_id", Typus.user_foreign_key
  end

  test "user_foreign_key setter presence" do
    assert Typus.respond_to?("user_foreign_key=")
  end

end
