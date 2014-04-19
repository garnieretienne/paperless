require 'test_helper'

class LabelTest < ActiveSupport::TestCase

  test "a label should have a name and belongs to an user" do
    label = Label.new
    assert !label.valid?
    assert label.errors[:name].include? "can't be blank"
  end

  test "label name must be unique in the user scope" do
    label = Label.new user: users(:curt_cobain), name: users(:curt_cobain).labels.first.name
    assert !label.valid?
    assert label.errors[:name].include? "has already been taken"
  end

  test "a label can have many documents" do
    assert_not_nil labels(:one).documents
  end

  test "a label cannot be attached to a document not owned by the label owner" do
    user1_document = users(:curt_cobain).documents.first
    user2_label = users(:john_smith).labels.first
    user2_label.documents << user1_document
    assert !user2_label.valid?
    assert user2_label.errors[:documents].include? "does not have the same owners"
  end
end
