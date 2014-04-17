require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user must have a first name, a last name, an email and a password on creation" do
    user = User.new
    assert !user.valid?
    assert user.errors[:first_name].include? "can't be blank"
    assert user.errors[:last_name].include? "can't be blank"
    assert user.errors[:email].include? "can't be blank"
    assert user.errors[:password].include? "can't be blank"
  end

  test "user email address must be unique" do
    user = User.new first_name: "Curt", last_name: "Cobain", email: "curt.cobain@domain.tld"
    assert !user.valid?
    assert user.errors[:email].include? "has already been taken"
  end

  test "user have many documents" do
    assert_not_nil users(:curt_cobain).documents
  end

  test "user full name" do
    assert_equal "Curt Cobain", users(:curt_cobain).full_name
  end
end
