require "test_helper"

class RegexTest < ActiveSupport::TestCase

  test "email_regex matches valid emails" do
    ["john@example.com",
     "john+locke@example.com",
     "john.locke@example.com",
     "john.locke@example.us"].each do |value|
      assert_match Typus::Regex::Email, value
    end
  end

  test "email_regex not matches invalid emails" do
    [%Q(this_is_chelm@example.com\n<script>location.href="http://spammersite.com"</script>),
     "admin",
     "TEST@EXAMPLE.COM",
     "test@example",
     "test@example.c",
     "testexample.com"].each do |value|
      assert_no_match Typus::Regex::Email, value
    end
  end

  test "domain_regex matches valid domains" do
    ["example.com",
     "site1.example.com",
     "site-with-dash.com",
     "sub-domain.with-dash.com"].each do |value|
      assert_match Typus::Regex::Domain, value
    end
  end

  test "domain_regex not matches invalid domains" do
    ["example",
     "site1_with_underscore.com",
     "site+with-non-accepted-chars.com"].each do |value|
      assert_no_match Typus::Regex::Domain, value
    end
  end

  test "uri_regex matches valid urls" do
    ["http://example.com",
     "http://www.example.com",
     "http://www.example.es",
     "http://www.example.co.uk",
     "http://four.sentenc.es",
     "http://www.ex-ample.com"].each do |value|
      assert_match Typus::Regex::Url, value
    end
  end

  test "uri_regex not matches invalid urls" do
    [%Q(this_is_chelm@example.com\n<script>location.href="http://spammersite.com"</script>),
     "example.com",
     "http://examplecom",
     "http://ex+ample.com"].each do |value|
      assert_no_match Typus::Regex::Url, value
    end
  end

end
