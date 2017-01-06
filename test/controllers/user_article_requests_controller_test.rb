require 'test_helper'

class UserArticleRequestsControllerTest < ActionController::TestCase
  setup do
    @user_article_request = user_article_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_article_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_article_request" do
    assert_difference('UserArticleRequest.count') do
      post :create, user_article_request: { article_id: @user_article_request.article_id, receiver_id: @user_article_request.receiver_id, user_id: @user_article_request.user_id, text: @user_article_request.text }
    end

    assert_redirected_to user_article_request_path(assigns(:user_article_request))
  end

  test "should show user_article_request" do
    get :show, id: @user_article_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_article_request
    assert_response :success
  end

  test "should update user_article_request" do
    patch :update, id: @user_article_request, user_article_request: { article_id: @user_article_request.article_id, receiver_id: @user_article_request.receiver_id, user_id: @user_article_request.user_id, text: @user_article_request.text }
    assert_redirected_to user_article_request_path(assigns(:user_article_request))
  end

  test "should destroy user_article_request" do
    assert_difference('UserArticleRequest.count', -1) do
      delete :destroy, id: @user_article_request
    end

    assert_redirected_to user_article_requests_path
  end
end
