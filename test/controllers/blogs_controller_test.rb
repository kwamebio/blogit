require "test_helper"

class BlogsControllerTest < ActionDispatch::IntegrationTest

  test "shows blog on index" do 
    get blogs_path
    assert_select 'h2', 'Showing 1 frontpage story'
    assert_select 'div#content div.blog', count: 1
  end

  test "show stories in bin" do
    get bin_blogs_path
    assert_select 'h2', 'Showing 2 upcoming blogs'
    assert_select 'div#content div.blog', count: 2
  end

  test "show blog vote elements" do
    login_user
    get blog_path(blogs(:one))
  end

  test "does not show vote button if not logged in" do 
    get blog_path(blogs(:one))
    assert_select 'div#vote_link', false
  end

  test "show_navigation menu" do
    get blogs_path
    assert_select 'ul#navigation li', 3
  end

  test "show blog submittier" do 
    get blog_path(blogs(:one))
    assert_select 'p.submitted_span a', 'Kwame Agyemang'
  end

  
  test "should get index" do
    get blogs_index_url
    assert_response :success
  end

  test "should get new" do
    get :new 
    assert_response :success
    assert_template 'new'
    assert_not_nil assigns(:blog)
  end

  test"new shows new form" do
    get new_blog_path
    assert_select 'form div', count: 2
  end

  test "should get index" do 
    get blogs_url
    assert_response :success
  end

  test "adds a blog" do 
    assert_difference "Blog.count" do 
      post blogs_path, params: {
        blog: {
          name: 'test blog',
          link: 'http://wwww.test.com'
        }
      }
    end
    assert_redirected_to blogs_path
    assert_not_nil flash[:notice]
  end

  test "rejects when missing blog attribute" do
    assert_no_difference "Blog.count" do
      post blogs_path, params: {
        blog: {name: 'blog without a link'}
      }
    end
  end

  test "show blog" do
    get blog_path(blogs(:one))
    assert_response :success
    assert response.body.include?(blogs(:one.name))
  end

  test "show blog vote elements" do 
    get blog_path(blogs(:one))
    assert_select 'h2 span#vote_score'
    assert_select 'ul#vote_history li', count:2
    assert_select 'div#vote_form form'
  end

  test "show blog submitter" do 
    get blog_path(blogs(:one))
    assert_select 'p.submitted_by span', 'Kwame Agyemang'
  end

  test "indicates not logged in" do 
    get blogs_path 
    assert_select 'div#login_logout em', 'Not logged in.'
  end

  test "show navigation menu" do
    get blogs_path
    assert_select 'ul#navigation li', 2
  end

  test "gets blogs" do
    get blogs_path
    assert_response :success
    assert response.body.include?(blogs(:promoted).name)
  end

  test "gets bin" do
    get bin_blogs_path
    assert_response :success
    assert response.body.include?(blogs(:two).name)
  end

end
