require 'test_helper'

class FutureUsersControllerTest < ActionController::TestCase
  setup do
    @future_user = future_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:future_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create future_user" do
    assert_difference('FutureUser.count') do
      post :create, future_user: { email: @future_user.email }
    end

    assert_redirected_to future_user_path(assigns(:future_user))
  end

  test "should show future_user" do
    get :show, id: @future_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @future_user
    assert_response :success
  end

  test "should update future_user" do
    put :update, id: @future_user, future_user: { email: @future_user.email }
    assert_redirected_to future_user_path(assigns(:future_user))
  end

  test "should destroy future_user" do
    assert_difference('FutureUser.count', -1) do
      delete :destroy, id: @future_user
    end

    assert_redirected_to future_users_path
  end
end
