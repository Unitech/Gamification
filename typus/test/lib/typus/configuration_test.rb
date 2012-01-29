require "test_helper"

class ConfigurationTest < ActiveSupport::TestCase

=begin
  should "verify typus roles is loaded" do
    assert Typus::Configuration.respond_to?(:roles!)
    assert_equal Hash, Typus::Configuration.roles!.class
  end

  should "verify typus config file is loaded" do
    assert Typus::Configuration.respond_to?(:models!)
    assert_equal Hash, Typus::Configuration.models!
  end

  should "load configuration files from config broken" do
    Typus.expects(:config_folder).at_least_once.returns("test/fixtures/config/broken")
    assert_not_equal Hash.new, Typus::Configuration.roles!
    assert_not_equal Hash.new, Typus::Configuration.models!
  end

  should "load configuration files from config empty" do
    Typus.expects(:config_folder).at_least_once.returns("test/fixtures/config/empty")
    assert_equal Hash.new, Typus::Configuration.roles!
    assert_equal Hash.new, Typus::Configuration.models!
  end

  should "load configuration files from config ordered" do
    Typus.expects(:config_folder).at_least_once.returns("test/fixtures/config/ordered")
    expected = { "admin" => { "categories" => "read" } }
    assert_equal expected, Typus::Configuration.roles!
  end

  should "load configuration files from config unordered" do
    Typus.expects(:config_folder).at_least_once.returns("test/fixtures/config/unordered")
    expected = { "admin" => { "categories" => "read, update" } }
    assert_equal expected, Typus::Configuration.roles!
  end

  should "load configuration files from config default" do
    Typus.expects(:config_folder).at_least_once.returns("test/fixtures/config/default")
    assert_not_equal Hash.new, Typus::Configuration.roles!
    assert_not_equal Hash.new, Typus::Configuration.models!
    assert Typus.resources.empty?
  end
=end

end
