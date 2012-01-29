# -*- encoding: utf-8 -*-

require "test_helper"

class Admin::ResourcesHelperTest < ActiveSupport::TestCase

  include Admin::ResourcesHelper

  def render(*args); args; end

  setup do
    @expected = ["helpers/admin/resources/search", {:hidden_filters => {}}]
  end

  test "search rejects controller and action params" do
    parameters = {"controller"=>"admin/posts", "action"=>"index"}
    assert_equal @expected, search(Entry, parameters)
  end

  # Why do you need the pagination page for a new search?
  test "search rejects page param" do
    parameters = {"page"=>"1"}
    assert_equal @expected, search(Entry, parameters)
  end

  # TODO: I want to think about it ...
  test "search rejects locale params" do
    parameters = {"locale"=>"jp"}
    assert_equal @expected, search(Entry, parameters)
  end

  # TODO: I want to think about it ...
  test "search rejects to sort_order and order_by" do
    parameters = {"sort_order"=>"asc", "order_by"=>"title"}
    assert_equal @expected, search(Entry, parameters)
  end

  test "search rejects utf8 param because form already contains it" do
    parameters = {"utf8"=>"✓"}
    assert_equal @expected, search(Entry, parameters)
  end

  test "search rejects search param because form already contains it" do
    parameters = {"search"=>"Chunky Bacon"}
    assert_equal @expected, search(Entry, parameters)
  end

  test "search not rejects applied filters" do
    parameters = {"published"=>"true", "user_id"=>"1"}
    expected = ["helpers/admin/resources/search", {:hidden_filters=>{"published"=>"true", "user_id"=>"1"}}]
    assert_equal expected, search(Entry, parameters)
  end

end
