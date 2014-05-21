require 'test_helper'

class ModulesControllerTest < ActionController::TestCase

  def setup
    authenticate_user users(:curt_cobain)
  end

  test "should get the HTML code of an allowed module" do
    post :render_module, module_name: "progress_bar", locals: {
      id: "testing", filename: "testing"
    }
    assert_response :success
  end

  test "should not get the HTML code of an unallowed module" do
    post :render_module, module_name: "non_existant_module", locals: {}
    assert_response :missing
  end
end
