require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
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

  test "should open the PDF document in the browser" do
    get :open, id: documents(:one).id
    assert_equal 'inline; filename="empty.pdf"', response.header["Content-Disposition"]
    assert_response :success
  end

  test "should delete a document" do
    assert_difference "Document.count", -1 do
      delete :destroy, id: documents(:one).id
      assert_response :redirect
      assert_redirected_to documents_path
    end
  end
end
