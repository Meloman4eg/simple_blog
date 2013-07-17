require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @post = posts(:one)
  end

  def teardown
    @post = nil
  end

  def authorize
    request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret")
  end

  # Tests

  test "should show post" do
    get :show, id: @post.id
    assert_response :success
  end

  test "should show all posts" do
    get :index
    assert_response :success
  end

  test "should create new post" do
    authorize
    assert_difference('Post.count', 1) do
      post :create, post: {title: "Some title"}
    end

    assert_redirected_to post_path(assigns :post)
  end

  test "should update post" do
    authorize
    @params = {title: "Other title", text: "Some text"}
    patch :update, id: @post.id, post: @params

    assert_equal @params[:title], (assigns :post).title
    assert_equal @params[:text], (assigns :post).text
    assert_redirected_to post_path(assigns :post)
  end

  test "should destroy post" do
    authorize
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.id
    end

    assert_redirected_to posts_path
  end
end
