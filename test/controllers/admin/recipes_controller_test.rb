require 'test_helper'

class Admin::RecipesControllerTest < ActionController::TestCase
  setup do
    @admin_recipe = admin_recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_recipe" do
    assert_difference('Admin::Recipe.count') do
      post :create, admin_recipe: { food_id: @admin_recipe.food_id, product_id: @admin_recipe.product_id, weight: @admin_recipe.weight }
    end

    assert_redirected_to admin_recipe_path(assigns(:admin_recipe))
  end

  test "should show admin_recipe" do
    get :show, id: @admin_recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_recipe
    assert_response :success
  end

  test "should update admin_recipe" do
    patch :update, id: @admin_recipe, admin_recipe: { food_id: @admin_recipe.food_id, product_id: @admin_recipe.product_id, weight: @admin_recipe.weight }
    assert_redirected_to admin_recipe_path(assigns(:admin_recipe))
  end

  test "should destroy admin_recipe" do
    assert_difference('Admin::Recipe.count', -1) do
      delete :destroy, id: @admin_recipe
    end

    assert_redirected_to admin_recipes_path
  end
end
