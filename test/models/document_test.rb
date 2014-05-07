require 'test_helper'

class DocumentTest < ActiveSupport::TestCase

  test "a document must have a title a file id and belongs to an user" do
    document = Document.new
    assert !document.valid?
    assert document.errors[:title].include? "can't be blank"
    assert document.errors[:file].include? "can't be blank"
    assert document.errors[:owner].include? "can't be blank"
  end

  test "should create a document from a file" do
    document = Document.from_file(
      file: File.new(fixture_file_path("empty.pdf")),
      owner: users(:curt_cobain)
    )
    assert document.valid?
    assert_equal "empty", document.title
  end

  test "should create a document from an image file and convert it to a pdf file" do
    document = Document.from_file(
      file: File.new(fixture_file_path("image.jpg")),
      owner: users(:curt_cobain)
    )
    assert document.valid?
    assert_equal "image.pdf", document.file.filename
    assert_equal "image", document.title
  end

  test "should return a non valid document if no file is provided creating a document from a file" do
    document = Document.from_file(
      owner: users(:curt_cobain)
    )
    assert !document.valid?
    assert document.errors[:title].include? "can't be blank"
    assert document.errors[:file].include? "can't be blank"
  end

  test "a document can have many labels" do
    assert_not_nil documents(:one).labels
  end

  test "a document cannot attach a label not owned by the document owner" do
    user1_document = users(:curt_cobain).documents.first
    user2_label = users(:john_smith).labels.first
    user1_document.labels << user2_label
    assert !user1_document.valid?
    assert user1_document.errors[:labels].include? "does not have the same owners"
  end
end
