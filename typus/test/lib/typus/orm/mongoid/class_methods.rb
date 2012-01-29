require "test_helper"

class MongoidClassMethodsTest < ActiveSupport::TestCase

  test "model_fields" do
    expected = {:name=>:string, :description=>:string}
    assert_equal expected, Hit.model_fields
  end

end
