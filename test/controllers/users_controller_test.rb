require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "show user" do
    get user_path(users(:kwame))
    assert_response :success
    assert response.body.include?(users(:kwame).name)
  end

  test "show submitted blogs" do
    get user_path(users(:kwame))
    assert_select 'div#blogs_submitted div.blog', count: 2
  end

  test "show stories voted on" do
    get user_path(users(:kwame))
    assert_select 'div#blogs_voted_on div.blog', count: 1
  end
end
