require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "has a blog association" do
assert_equal 2, users(:kwame).blogs.size
assert users(:kwaku).blogs.includes blogs(:one)
  end

  test "has a votes association" do 
    assert_equal 1, users(:kwame).votes.size
    assert users(:kwaku).votes.includes votes(:two)
  end

  test "voted on association" do 
    assert_equal [ blogs(:one) ],
    users(:glenn).blogs_voted_on
  end
end
