require 'test_helper'

class StockitemSelectionsControllerTest < ActionController::TestCase
  setup do
    @stockitem_selection = stockitem_selections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stockitem_selections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stockitem_selection" do
    assert_difference('StockitemSelection.count') do
      post :create, stockitem_selection: {  }
    end

    assert_redirected_to stockitem_selection_path(assigns(:stockitem_selection))
  end

  test "should show stockitem_selection" do
    get :show, id: @stockitem_selection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stockitem_selection
    assert_response :success
  end

  test "should update stockitem_selection" do
    patch :update, id: @stockitem_selection, stockitem_selection: {  }
    assert_redirected_to stockitem_selection_path(assigns(:stockitem_selection))
  end

  test "should destroy stockitem_selection" do
    assert_difference('StockitemSelection.count', -1) do
      delete :destroy, id: @stockitem_selection
    end

    assert_redirected_to stockitem_selections_path
  end
end
