require 'test_helper'

class LabelsControllerTest < ActionController::TestCase

  def setup
    authenticate_user users(:curt_cobain)
  end

  test "should get show" do
    get :show, id: labels(:one)
    assert_not_nil assigns(:documents)
    assert_not_nil assigns(:label)
    assert_response :success
  end

  test "should create a new label" do
    user = users(:curt_cobain)
    request.env['HTTP_REFERER'] = root_path
    assert_difference "user.labels.count" do
      post :create, label: {name: "my uber new label"}
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  test "should delete label" do
    user = users(:curt_cobain)
    request.env['HTTP_REFERER'] = root_path
    assert_difference "user.labels.count", -1 do
      delete :destroy, id: user.labels.first.id
      assert_response :redirect
      assert_redirected_to root_path
    end
  end
end
