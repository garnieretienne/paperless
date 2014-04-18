require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should authenticate the user" do
    post :authenticate, email: users(:curt_cobain).email, password: "95ec7cf0070"
    assert_response :redirect
    assert_equal users(:curt_cobain).id, session[:user_id]
    assert_redirected_to documents_path
  end

  test "should fail to authenticate the user" do
    post :authenticate, email: users(:curt_cobain).email, password: "badPassword"
    assert_response :success
    assert_nil session[:user_id]
  end

  test "should get logout" do
    authenticate_user users(:curt_cobain)
    get :logout
    assert_response :redirect
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end
end
