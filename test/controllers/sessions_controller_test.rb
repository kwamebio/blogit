require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "new shows a login form" do 
    get new_session_path
    assert_response :success
    assert_select 'form p', 4
  end

  test "perform user login" do 
    post session_path, params: {email: 'kwameagyemang73@gmail.com', password: 'kbad1234'}
    assert_equal user(:kwame).id, session[:user_id]
  end

  test "bad login fails" do 
    post session_path, params: {email: 'noone@nowhere.com', password: 'none'}
    assert_response :success
    assert_nil session[:user_id]
  end

  test "redirects after login with return url" do
    get new_blog_path
    assert_redirected_to new_session_path
    post session_path,
      params: {
        email: 'kwameagyemang73@gmail.com',
        password: 'kbad1234'
      }
    assert_redirected_to new_blog_path
    end

    test "logout and clear session" do 
      post(
        session_path,
        params: {email: 'kwameagyemang73@gmail.com', password: 'kbad1234'}
      )
      assert_not_nil session[:user_id]

      delete session_path
      assert_response :success
      assert_select 'h2', 'Logout successful'

      assert_nil session[:user_id]
    end

  test "should get new" do
    get sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get sessions_destroy_url
    assert_response :success
  end
end
