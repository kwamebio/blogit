require "test_helper"

class VoteTest < ActiveSupport::TestCase
  test "votes have a blog" do
    assert_equal blogs(:one), votes(:one).blog
  end
  
  test "is associated with a user" do 
    assert_equal users(:kwaku), votes(:two).user
  end 
end
