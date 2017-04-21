require 'test_helper'

class StockitemsControllerTest < ActionController::TestCase
  setup do
    @stockitem = stockitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stockitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stockitem" do
    assert_difference('Stockitem.count') do
      post :create, stockitem: { details_hint: @stockitem.details_hint, picture: @stockitem.picture, rate_eur: @stockitem.rate_eur, rate_interval: @stockitem.rate_interval, title: @stockitem.title_de }
    end

    assert_redirected_to stockitem_path(assigns(:stockitem))
  end

  test "should show stockitem" do
    get :show, id: @stockitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stockitem
    assert_response :success
  end

  test "should update stockitem" do
    patch :update, id: @stockitem, stockitem: { details_hint: @stockitem.details_hint, picture: @stockitem.picture, rate_eur: @stockitem.rate_eur, rate_interval: @stockitem.rate_interval, title: @stockitem.title_de }
    assert_redirected_to stockitem_path(assigns(:stockitem))
  end

  test "should destroy stockitem" do
    assert_difference('Stockitem.count', -1) do
      delete :destroy, id: @stockitem
    end

    assert_redirected_to stockitems_path
  end
end
