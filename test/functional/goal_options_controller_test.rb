require 'test_helper'

class GoalOptionsControllerTest < ActionController::TestCase
  setup do
    @goal_option = goal_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goal_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal_option" do
    assert_difference('GoalOption.count') do
      post :create, goal_option: { is_system: @goal_option.is_system, name: @goal_option.name }
    end

    assert_redirected_to goal_option_path(assigns(:goal_option))
  end

  test "should show goal_option" do
    get :show, id: @goal_option
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goal_option
    assert_response :success
  end

  test "should update goal_option" do
    put :update, id: @goal_option, goal_option: { is_system: @goal_option.is_system, name: @goal_option.name }
    assert_redirected_to goal_option_path(assigns(:goal_option))
  end

  test "should destroy goal_option" do
    assert_difference('GoalOption.count', -1) do
      delete :destroy, id: @goal_option
    end

    assert_redirected_to goal_options_path
  end
end
