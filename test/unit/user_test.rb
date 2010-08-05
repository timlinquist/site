require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  model_template_for User do
    {
      :username              => "tester",
      :email                 => "test@test.com",
      :password              => '123456',
      :password_confirmation => '123456',
      :time_zone             => 'Pacific Time (US & Canada)'
    }
  end

  test_validations_for :username, :uniqueness
  test_validations_for :email, :uniqueness
  test_validations_for :username, :presence
  test_validations_for :time_zone, :presence

  test "create user should set password_salt and password_hash" do
    u = create_user

    assert u.save
    refute_equal nil, u.password_salt, "password_salt was nil"
    refute_equal nil, u.password_hash, "password_hash was nil"
  end

  test "attributes are setable" do
    u = create_user

    assert_equal 'tester', u.username
    assert_equal 'test@test.com', u.email
    assert_equal 'Pacific Time (US & Canada)', u.time_zone

  end

  test "user with mismatched passwords doesn't save" do
    u = create_user

    u.password_confirmation = '654321'

    refute u.save
  end

  test "password hash says the same when no password is set" do
    u1a = create_user

    assert u1a.password?("123456")

    u1b = User.find(u1a.id)
    u1b.first_name = "Test"
    u1b.last_name = "Master"

    assert u1b.save!

    assert u1b.password?("123456"), "password was not messed up"
    assert_equal u1a.password_salt, u1b.password_salt
    assert_equal u1a.password_hash, u1b.password_hash
  end

  test "password hash should change when password is set, salt does not" do
    u = create_user

    original_salt = u.password_salt
    original_hash = u.password_hash

    u.password = "newpassword"
    u.password_confirmation = "newpassword"

    assert u.save!

    assert_equal original_salt, u.password_salt,
      "password_salt changed..."
    refute_equal original_hash, u.password_hash,
      "password_hash remained the same"
  end

  test "password_confirmation is required to change password" do
    # TODO - write this test, currently from script/console I 
    # can set password and save successfully.
  end
end
