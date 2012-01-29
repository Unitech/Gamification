require "test_helper"

class ObjectTest < ActiveSupport::TestCase

  test "is_sti?" do
    assert Case.is_sti?
    assert !Entry.is_sti?
  end

end
