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
end
