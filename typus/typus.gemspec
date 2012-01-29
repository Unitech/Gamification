# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "typus/version"

files = `git ls-files`.split("\n")
test_files = `git ls-files -- test/*`.split("\n")
ignores = `git ls-files -- doc/* Guardfile .travis.yml .gitignore`.split("\n")

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "typus"
  s.version = Typus::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Francesc Esplugas"]
  s.email = ["support@typuscmf.com"]
  s.homepage = "http://www.typuscmf.com/"
  s.summary = "Effortless backend interface for Ruby on Rails applications. (Admin scaffold generator)"
  s.description = "Ruby on Rails Admin Panel (Engine) to allow trusted users edit structured content."

  s.rubyforge_project = "typus"

  s.files         = files - test_files - ignores
  s.test_files    = []
  s.require_paths = ["lib"]

  s.add_dependency "bcrypt-ruby", "~> 3.0.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "kaminari", "~> 0.12.4"
  s.add_dependency "rails", "~> 3.1.3"

  # Development dependencies are defined in the `Gemfile`.
end
