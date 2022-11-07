require "test_helper"

class VotesControllerTest < ActionController::TestCase

  setup do
    login_user
  end

  teardown do 
    logout_user
  end

  test "creates vote" do
    assert_difference 'blogs(:two).votes.count' do
      post blog_votes_path(blogs(:two))
    end    
  end

  test "create vote with ajax" do 
    post blog_votes_path(blogs(:two)), xhr: true
    assert_response :success
  end

  test "redirect after vote with http post" do 
    post blog_votes_path(blogs(:two))
    assert_redirected_to blog_path(blogs(:two))
  end

  test "stroed user with vote" do
    post blog_votes_path(blogs(:two))
    blogs(:two).reload
    assert_equal users(:kwame), blogs(:two).votes.last.user
  end
