require 'test_helper'

class Admin::FoodsControllerTest < ActionController::TestCase
  setup do
    @admin_food = admin_foods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_foods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_food" do
    assert_difference('Admin::Food.count') do
      post :create, admin_food: {  }
    end

    assert_redirected_to admin_food_path(assigns(:admin_food))
  end

  test "should show admin_food" do
    get :show, id: @admin_food
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_food
    assert_response :success
  end

  test "should update admin_food" do
    patch :update, id: @admin_food, admin_food: {  }
    assert_redirected_to admin_food_path(assigns(:admin_food))
  end

  test "should destroy admin_food" do
    assert_difference('Admin::Food.count', -1) do
      delete :destroy, id: @admin_food
    end

    assert_redirected_to admin_foods_path
  end
end
