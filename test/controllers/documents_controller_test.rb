require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase

  def setup
    authenticate_user users(:curt_cobain)
  end

  test "should not be able to access any pages if non-authenticated" do
    deauthenticated_user
    get :index
    assert_response :redirect
    assert_redirected_to login_path
  end

  test "should get index" do
    get :index
    assert_not_nil assigns(:documents)
    assert_not_nil assigns(:new_document)
    assert_response :success
  end

  test "should create a document" do
    assert_difference "Document.count" do
      post :create, document: {file: fixture_file_upload('files/empty.pdf')}
      assert_response :redirect
      assert_redirected_to documents_path
    end
  end

  test "should create as many documents as sended" do
    assert_difference "Document.count", 2 do
      post :create, document: {file: [
        fixture_file_upload('files/empty.pdf'),
        fixture_file_upload('files/empty.pdf')
      ]}
      assert_response :redirect
      assert_redirected_to documents_path
    end
  end

  test "should open the PDF document in the browser" do
    get :open, id: documents(:one).id
    assert_equal 'inline; filename="empty.pdf"', response.header["Content-Disposition"]
    assert_response :success
  end

  test "should delete a document" do
    assert_difference "Document.count", -1 do
      request.env['HTTP_REFERER'] = documents_path
      delete :destroy, id: documents(:one).id
      assert_response :redirect
      assert_redirected_to documents_path
    end
  end
end
