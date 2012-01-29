require "test_helper"

class ActionsTest < ActiveSupport::TestCase

  include Typus::Controller::Actions

  ##
  # add_resource_action
  #

  test "add_resource_action" do
    output = add_resource_action("something")
    assert_equal [["something"]], @resource_actions
  end

  test "add_resource_action when no params are set" do
    add_resource_action
    assert @resource_actions.empty?
  end

  ##
  # prepend_resource_action
  #

  test "prepend_resource_action without args" do
    prepend_resource_action
    assert @resource_actions.empty?
  end

  test "prepend_resource_action with args" do
    prepend_resource_action("something")
    assert_equal [["something"]], @resource_actions
  end

  test "prepend_resource_action prepending an action without args" do
    add_resource_action("something")
    prepend_resource_action
    assert_equal [["something"]], @resource_actions
  end

  test "prepend_resource_action prepending an action with args" do
    add_resource_action("something")
    prepend_resource_action("something_else")
    assert_equal [["something_else"], ["something"]], @resource_actions
  end

  ##
  # append_resource_action
  #

  test "append_resource_action without args" do
    append_resource_action
    assert @resource_actions.empty?
  end

  test "append_resource_action with args" do
    append_resource_action("something")
    assert_equal [["something"]], @resource_actions
  end

  test "append_resource_action appending an action without args" do
    add_resource_action("something")
    append_resource_action
    assert_equal [["something"]], @resource_actions
  end

  test "append_resource_action appending an action with args" do
    add_resource_action("something")
    append_resource_action("something_else")
    assert_equal [["something"], ["something_else"]], @resource_actions
  end

  ##
  # add_resources_action
  #

  test "add_resources_action" do
    add_resources_action("something")
    assert_equal [["something"]], @resources_actions
  end

  test "add_resources_action when no params are set" do
    add_resources_action
    assert @resources_actions.empty?
  end

  ##
  # prepend_resources_action
  #

  test "prepend_resources_action without args" do
    prepend_resources_action
    assert @resources_actions.empty?
  end

  test "prepend_resources_action with args" do
    prepend_resources_action("something")
    assert_equal [["something"]], @resources_actions
  end

  test "prepend_resources_action prepending an action without args" do
    add_resources_action("something")
    prepend_resources_action
    assert_equal [["something"]], @resources_actions
  end

  test "prepend_resources_action prepending an action with args" do
    add_resources_action("something")
    prepend_resources_action("something_else")
    assert_equal [["something_else"], ["something"]], @resources_actions
  end

  ##
  # append_resources_action
  #

  test "append_resources_action without args" do
    append_resources_action
    assert @resources_actions.empty?
  end

  test "append_resources_action with args" do
    append_resources_action("something")
    assert_equal [["something"]], @resources_actions
  end

  test "append_resources_action appending an action without args" do
    add_resources_action("something")
    append_resources_action
    assert_equal [["something"]], @resources_actions
  end

  test "append_resources_action appending an action with args" do
    add_resources_action("something")
    append_resources_action("something_else")
    assert_equal [["something"], ["something_else"]], @resources_actions
  end

end
