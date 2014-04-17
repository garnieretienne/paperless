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

  test "should return a non valid document if no file is provided creating a document from a file" do
    document = Document.from_file(
      owner: users(:curt_cobain)
    )
    assert !document.valid?
    assert document.errors[:title].include? "can't be blank"
    assert document.errors[:file].include? "can't be blank"
  end
end
