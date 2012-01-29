require "test_helper"

class HashTest < ActiveSupport::TestCase

  test "compact" do
    hash = { "a" => "", "b" => nil, "c" => "hello" }
    expected = { "c" => "hello" }
    assert_equal expected, hash.compact
  end

  test "cleanup" do
    whitelist = %w(controller action id _input _popup resource attribute)
    whitelist.each do |w|
      expected = { w => w }
      assert_equal expected, expected.dup.cleanup
    end
  end

  test "cleanup rejects unwanted stuff" do
    hash = {"_nullify" => "dragonfly"}
    assert hash.cleanup.empty?
  end

end
